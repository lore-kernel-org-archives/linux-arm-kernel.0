From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 22:13:17 +0800
Subject: [PATCH] ARM: imx: build cpuidle-imx6sx.o for imx6ul
In-Reply-To: <20160906125338.1530603-1-arnd@arndb.de>
References: <20160906125338.1530603-1-arnd@arndb.de>
Message-ID: <20160908141317.GF16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 02:53:25PM +0200, Arnd Bergmann wrote:
> The imx6ul soc code gained support for cpuidle, but that causes
> a link failure if CONFIG_SOC_IMX6SX is disabled:
> 
> arch/arm/mach-imx/mach-imx6ul.o: In function `imx6ul_init_late':
> mach-imx6ul.c:(.init.text+0xc): undefined reference to `imx6sx_cpuidle_init'
> 
> This adds the file containing the imx6sx_cpuidle_init function
> to the kernel for 6ul-only configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 547e8f526959 ("ARM: imx: add cpuidle support for i.mx6ul")

Applied, thanks.
