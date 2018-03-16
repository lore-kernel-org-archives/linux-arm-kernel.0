From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Mar 2018 08:48:45 +0800
Subject: [PATCH 1/2] ARM: imx: fix imx6sll-only build
In-Reply-To: <20180315151345.3089601-1-arnd@arndb.de>
References: <20180315151345.3089601-1-arnd@arndb.de>
Message-ID: <20180316004843.GM26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:13:18PM +0100, Arnd Bergmann wrote:
> When selecting SOC_IMX6SLL but not SOC_IMX6SL, we get a link error:
> 
> arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
> mach-imx6sl.c:(.init.text+0x14): undefined reference to `imx6sl_cpuidle_init'
> 
> This adds the missing line to the Makefile to also build the cpuidle
> support that we need here.
> 
> Fixes: dee5dee2a5b2 ("ARM: imx: Add basic msl support for imx6sll")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>
