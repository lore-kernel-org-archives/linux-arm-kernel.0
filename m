From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 11 May 2018 17:00:28 +0000
Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
In-Reply-To: <20180511033530.7931-3-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
 <20180511033530.7931-3-yinbo.zhu@nxp.com>
Message-ID: <AM4PR0401MB16995DFED0376ACE0DD5E7A78F9F0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Yinbo Zhu [mailto:yinbo.zhu at nxp.com]
> Sent: Thursday, May 10, 2018 10:35 PM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Catalin Marinas )
> <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>;
> Lorenzo Pieralisi ) <lorenzo.pieralisi@arm.com>; Leo Li <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; Ran Wang <ran.wang_1@nxp.com>;
> Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; Shawn Guo <shawnguo@kernel.org>; Madalin-cristian
> Bucur <madalin.bucur@nxp.com>; Z.q. Hou <zhiqiang.hou@nxp.com>; Jerry
> Huang <jerry.huang@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>;
> Qiang Zhao <qiang.zhao@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Jiaheng Fan <jiaheng.fan@nxp.com>; Po Liu
> <po.liu@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>; Horia Geant?
> <horia.geanta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Sumit
> Garg <sumit.garg@nxp.com>; costi <constantin.tudor@freescale.com>;
> Bogdan Purcareata <bogdan.purcareata@nxp.com>; Meng Yi
> <meng.yi@nxp.com>; Wang Dongsheng <dongsheng.wang@nxp.com>; open
> list:CLOCKSOURCE, CLOCKEVENT DRIVERS <linux-kernel@vger.kernel.org>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org; open
> list:FREESCALE SOC DRIVERS <linuxppc-dev@lists.ozlabs.org>; Andy Tang
> <andy.tang@nxp.com>; Ying Zhang <ying.zhang22455@nxp.com>
> Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
> 
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Set RCPM for FTM when using FTM as wakeup source. Because the RCPM
> module of each platform has different big-end and little-end mode, there
> need to set RCPM depending on the platform.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,ftm-timer.txt    |    7 ++
>  drivers/soc/fsl/layerscape/ftm_alarm.c             |   92 ++++++++++++++++++-
>  2 files changed, 94 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> index aa8c402..15ead58 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> @@ -3,6 +3,13 @@ Freescale FlexTimer Module (FTM) Timer  Required
> properties:
> 
>  - compatible : should be "fsl,ftm-timer"

Hi Yingbo,

This is a change that breaks backward compatibility and not acceptable.

> + Possible compatibles for ARM:
> +     "fsl,ls1012a-ftm"
> +     "fsl,ls1021a-ftm"
> +     "fsl,ls1043a-ftm"
> +     "fsl,ls1046a-ftm"
> +     "fsl,ls1088a-ftm"
> +     "fsl,ls208xa-ftm"
>  - reg : Specifies base physical address and size of the register sets for the
>    clock event device and clock source device.
>  - interrupts : Should be the clock event device interrupt.
> diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c
> b/drivers/soc/fsl/layerscape/ftm_alarm.c
> index 6f9882f..811dcfa 100644
> --- a/drivers/soc/fsl/layerscape/ftm_alarm.c
> +++ b/drivers/soc/fsl/layerscape/ftm_alarm.c

There is no such file in the mainline kernel.  So it looks like the patch set is based on some internal git repo instead of the upstream Linux kernel.  This kind of patches shouldn't be sent to the upstream mailing list for review.

Regards,
Leo
