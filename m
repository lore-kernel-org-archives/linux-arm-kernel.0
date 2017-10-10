From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Oct 2017 13:44:17 +0200
Subject: [PATCH] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
In-Reply-To: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
References: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
Message-ID: <1507635857.2745.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 10.10.2017, 14:20 +0300 schrieb Leonard Crestez:
> Enable cpuidle support on i.MX6DL starting from
> IMX_CHIP_REVISION_1_1.

Did you mean 1.0 here and in the subject? This would make sense AFAICS,
 and is also in line with what the code change does.

> This also makes the code cleaner because 6q and 6dl actually have
> different revision histories.
> 
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> ?arch/arm/mach-imx/mach-imx6q.c | 3 ++-
> ?1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 45801b2..ef0c949 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -374,7 +374,8 @@ static void __init imx6q_init_late(void)
> > ?	?* WAIT mode is broken on TO 1.0 and 1.1, so there is no point
> > ?	?* to run cpuidle on them.
> > ?	?*/
> > -	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
> > +	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
> > +	????(cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
> > ?		imx6q_cpuidle_init();
> ?
> > ?	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
