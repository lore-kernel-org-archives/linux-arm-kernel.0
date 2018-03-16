From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Mar 2018 08:49:34 +0800
Subject: [PATCH 2/2] ARM: imx: select ARM_CPU_SUSPEND for CPU_IDLE as well
In-Reply-To: <20180315151345.3089601-2-arnd@arndb.de>
References: <20180315151345.3089601-1-arnd@arndb.de>
 <20180315151345.3089601-2-arnd@arndb.de>
Message-ID: <20180316004933.GN26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:13:19PM +0100, Arnd Bergmann wrote:
> The cpuidle support calls cpu_suspend(), which is compiled conditionally,
> and fails to link unless something selects CONFIG_ARM_CPU_SUSPEND.
> 
> arch/arm/mach-imx/cpuidle-imx6sx.o: In function `imx6sx_enter_wait':
> cpuidle-imx6sx.c:(.text+0x6c): undefined reference to `cpu_suspend'
> 
> This adds an explicit select statement here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>
