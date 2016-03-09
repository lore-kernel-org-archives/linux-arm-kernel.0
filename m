From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 09 Mar 2016 11:57:30 +0100
Subject: [PATCH v5 4/6] dt/bindings: power: add RK3399 SoCs header for
 power-domain
In-Reply-To: <56DFFCAA.2030401@gmail.com>
References: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
 <2748667.mSDu940Rq4@diego> <56DFFCAA.2030401@gmail.com>
Message-ID: <1757559.IpfTQRFBYT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 9. M?rz 2016, 18:36:26 schrieb Caesar Wang:
> ? 2016?03?09? 17:55, Heiko St?bner ??:
> > Hi Caesar,
> > 
> > Am Dienstag, 8. M?rz 2016, 18:45:06 schrieb Caesar Wang:
> >> ? 2016?03?03? 16:03, Elaine Zhang ??:
> >>> According to a description from TRM, add all the power domains
> >>> 
> >>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>> ---
> >>> 
> >>>    include/dt-bindings/power/rk3399-power.h | 53
> >>>    ++++++++++++++++++++++++++++++++ 1 file changed, 53 insertions(+)
> >>>    create mode 100644 include/dt-bindings/power/rk3399-power.h
> >>> 
> >>> diff --git a/include/dt-bindings/power/rk3399-power.h
> >>> b/include/dt-bindings/power/rk3399-power.h new file mode 100644
> >>> index 0000000..69fbd67
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/power/rk3399-power.h
> >>> @@ -0,0 +1,53 @@
> >>> +#ifndef __DT_BINDINGS_POWER_RK3399_POWER_H__
> >>> +#define __DT_BINDINGS_POWER_RK3399_POWER_H__
> >>> +
> >>> +/* VD_CORE_L */
> >>> +#define RK3399_PD_A53_L0	0
> >>> +#define RK3399_PD_A53_L1	1
> >>> +#define RK3399_PD_A53_L2	2
> >>> +#define RK3399_PD_A53_L3	3
> >>> +#define RK3399_PD_SCU_L		4
> >>> +
> >>> +/* VD_CORE_B */
> >>> +#define RK3399_PD_A72_B0	5
> >>> +#define RK3399_PD_A72_B1	6
> >>> +#define RK3399_PD_SCU_B		7
> >>> +
> >>> +/* VD_CENTER */
> >>> +#define RK3399_PD_CENTER	8
> >>> +#define RK3399_PD_VCODEC	9
> >>> +#define RK3399_PD_RGA		10
> >>> +#define RK3399_PD_IEP		11
> >>> +#define RK3399_PD_VDU		12
> >>> +
> >>> +/* VD_LOGIC */
> >>> +#define RK3399_PD_PERILP	13
> >>> +#define RK3399_PD_PERIHP	14
> >>> +#define RK3399_PD_VIO		15
> >>> +#define RK3399_PD_VO		16
> >> 
> >> ...
> >> ISP?
> >> 
> >>> +#define RK3399_PD_VOPB		17
> >>> +#define RK3399_PD_VOPL		18
> >>> +#define RK3399_PD_ISP0		19
> >>> +#define RK3399_PD_ISP1		20
> >>> +#define RK3399_PD_HDCP		21
> >>> +#define RK3399_PD_TCPD0		22
> >>> +#define RK3399_PD_TCPD1		23
> >>> +#define RK3399_PD_GIC		24
> >>> +#define RK3399_PD_ALIVE		25
> >>> +#define RK3399_PD_USB3		26
> >>> +#define RK3399_PD_SD		27
> >>> +#define RK3399_PD_CCI		28
> >>> +#define RK3399_PD_CCI0		29
> >>> +#define RK3399_PD_CCI1		30
> >>> +#define RK3399_PD_GMAC		31
> >>> +#define RK3399_PD_EMMC		32
> >>> +#define RK3399_PD_EDP		33
> >>> +#define RK3399_PD_SDIOAUDIO	34
> >>> +
> >>> +/* VD_GPU */
> >>> +#define RK3399_PD_GPU		35
> >>> +
> >>> +/* VD_PMU */
> >>> +#define RK3399_PD_PMU		36
> >>> +
> >> 
> >> Would you please follow the TRM?
> > 
> > could you elaborate a bit on what you mean?
> > 
> > Looking at the "Table 11-1 RK3399 Power Domain and Voltage Domain Summary"
> > in the TRM, Elaine's list seems to match that table quite nicely, so
> > looks ok to me at first glance.
> 
> That's also trivial...
> 
> The comments from the first time I saw this file and TRM.:-)
> 
> Can we define the lists according to order the TRM?
> 
> For example:
> 
> +/* VD_CORE_L */
> +#define RK3399_PD_A53_L0	0
> +#define RK3399_PD_A53_L1	1
> +#define RK3399_PD_A53_L2	2
> +#define RK3399_PD_A53_L3	3
> +#define RK3399_PD_SCU_L	4
> +
> +/* VD_CORE_B */
> +#define RK3399_PD_A72_B0	5
> +#define RK3399_PD_A72_B1	6
> +#define RK3399_PD_SCU_B	7
> +
> +/* VD_LOGIC */
> +#define RK3399_PD_PERILP	13
> +#define RK3399_PD_PERIHP	14
> +#define RK3399_PD_VIO		15
> +#define RK3399_PD_ISP0		16
> +#define RK3399_PD_ISP1		17
> +#define RK3399_PD_VO		18
> +#define RK3399_PD_HDCP	19
> +#define RK3399_PD_TCPD0	20
> +#define RK3399_PD_TCPD1	21
> .....
> 
> +/* VD_CENTER */
> ....
> 
> +/* VD_GPU */
> ....
> 
> +/* VD_PMU */
> 
> 
> Please ignore it and sorry the noise if that's the wrong ideas.:-)

I may be simply be blind, but I don't see the difference .... ah no, now I see 
it, some voltage domains are swapped in the original (VD_CENTER before 
VD_LOGIC, while in the TRM it's the other way around).

So while it doesn't matter much, I would slightly prefer the ordering being 
according to the TRM table. Reason is the same as for ordering the clock-tree 
according to the diagrams - it makes future reading easier ;-)


Heiko
