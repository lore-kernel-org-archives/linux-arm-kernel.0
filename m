From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 7 Sep 2016 02:44:58 +0000
Subject: [PATCH] ARM: imx: build cpuidle-imx6sx.c for imx6ul
In-Reply-To: <1473244244-8002-1-git-send-email-Anson.Huang@nxp.com>
References: <1473244244-8002-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <AM3PR04MB13157A7F65DFE4C59D3C5FD9F5F80@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, please ignore this patch, Arnd Bergmann <arnd@arndb.de> has summited a patch to fix this issue.

Best Regards!
Anson Huang



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Anson Huang
> Sent: 2016-09-07 6:31 PM
> To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Fabio Estevam Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> linux at armlinux.org.uk; kernel at pengutronix.de
> Subject: [PATCH] ARM: imx: build cpuidle-imx6sx.c for imx6ul
> 
> Fix build error when CONFIG_SOC_IMX6SX is disabled, as i.MX6UL reuses
> i.MX6SX's cpuidle driver.
> 
> arch/arm/mach-imx/built-in.o: In function `imx6ul_init_late':
> platform-spi_imx.c:(.init.text+0x445c): undefined reference to
> `imx6sx_cpuidle_init'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile index
> 2636adf..cab1289 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
> +obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
>  endif
> 
>  ifdef CONFIG_SND_IMX_SOC
> --
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
