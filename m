From: frank.li@nxp.com (Frank Li)
Date: Tue, 10 Jan 2017 14:53:35 +0000
Subject: [PATCH] ARM: imx: hide unused variable in #ifdef
In-Reply-To: <20170110130154.2994705-1-arnd@arndb.de>
References: <20170110130154.2994705-1-arnd@arndb.de>
Message-ID: <AMSPR04MB2637CED29E68AA48A81202188670@AMSPR04MB263.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, January 10, 2017 6:19 AM
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Arnd Bergmann
> <arnd@arndb.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Russell King <linux@armlinux.org.uk>; Frank Li
> <frank.li@nxp.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH] ARM: imx: hide unused variable in #ifdef
> 
> A bugfix added a new local variable that is only used inside of an #ifdef
> section, and unused if CONFIG_PERF_EVENTS is disabled:
> 
> arch/arm/mach-imx/mmdc.c:63:25: warning: 'cpuhp_mmdc_state' defined
> but not used [-Wunused-variable]
> 
> This moves the variable down inside that same ifdef.
> 
> Fixes: a051f220d6b9 ("ARM/imx/mmcd: Fix broken cpu hotplug handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm/mach-imx/mmdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 699157759120..c03bf28d8bbc 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -60,7 +60,6 @@
> 
>  #define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
> 
> -static enum cpuhp_state cpuhp_mmdc_state;  static int ddr_type;
> 
>  struct fsl_mmdc_devtype_data {
> @@ -82,6 +81,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
> 
>  #ifdef CONFIG_PERF_EVENTS
> 
> +static enum cpuhp_state cpuhp_mmdc_state;
>  static DEFINE_IDA(mmdc_ida);
> 
>  PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles,
> "event=0x00")
> --
> 2.9.0
