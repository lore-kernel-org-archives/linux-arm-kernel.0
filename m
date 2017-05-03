From: aisheng.dong@nxp.com (A.S. Dong)
Date: Wed, 3 May 2017 03:48:03 +0000
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
In-Reply-To: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
References: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Message-ID: <AM3PR04MB306B60CED1751FA382AFBB980160@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Leonard Crestez [mailto:leonard.crestez at nxp.com]
> Sent: Tuesday, May 02, 2017 10:46 PM
> To: Shawn Guo
> Cc: Leonard Crestez; Sascha Hauer; Jagan Teki; Fabio Estevam; Dong Aisheng;
> linux-arm-kernel at lists.infradead.org; linux-pm at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
> 
> Enable more common cpufreq governors in imx defconfig because this is very
> useful for testing. In particular you can't use cpufreq-set -f $FREQ
> without explicitly defining CONFIG_CPU_FREQ_GOV_USERSPACE=y.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Well, I think we do need this.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> 
> ---
> 
> It might make sense for all governors to be enabled by default from
> drivers/cpufreq/Kconfig and allow defconfigs to be shorter.
> Right now the descriptions for some of them includes a line that says "If
> in doubt, say Y" but the config options don't have actually have a default
> value defined and they effectively default to N.
> 
> Cycling via savedefconfig on shawnguo/for-next also generates some
> reordering for some newly added options CONFIG_TOUCHSCREEN_MAX11801=y and
> CONFIG_HID_MULTITOUCH=y. Those were not included but it's strange that
> this happens. Maybe those options were inserted manually, or otherwise
> there is an annoying bug in kconfig?
> 
>  arch/arm/configs/imx_v6_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index bb6fa56..bf1e7e3 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -55,6 +55,9 @@ CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>  CONFIG_ARM_IMX6Q_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
> --
> 2.7.4
