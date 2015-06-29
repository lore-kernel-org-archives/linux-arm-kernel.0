From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 29 Jun 2015 11:03:39 +0800
Subject: [RESEND PATCH 1/6] Document: bindings: DT: Add SMP enable
 method for MT6580 SoC platform
In-Reply-To: <1434650481-39421-2-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <srv_scott.shu@mediatek.com>
 <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
 <1434650481-39421-2-git-send-email-scott.shu@mediatek.com>
Message-ID: <1435547019.20584.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-19 at 02:01 +0800, Scott Shu wrote:
> For MT6580 SoC platform, the secondary cores are in powered off state
> as default, so compared with MT65xx series SoC, one new enable method
> is needed. This method using the SPM (System Power Manager) inside
> the SCYSYS to control the CPU power.
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index ac2903d..fb80b2e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -194,6 +194,7 @@ nodes to be present and contain the properties described below.
>  			    "marvell,armada-380-smp"
>  			    "marvell,armada-390-smp"
>  			    "marvell,armada-xp-smp"
> +			    "mediatek,mt6580-smp"
>  			    "mediatek,mt65xx-smp"
>  			    "mediatek,mt81xx-tz-smp"
>  			    "qcom,gcc-msm8660"

Hi

It seems we have 3 different kinds of cpu enable method now, and
mt65xx-smp doesn't cover all mt65xx series. So maybe it make sense to
change naming before it got merged.

Short summary for these methods:

mt65xx-smp:    	For mt65xx socs which wakeup all cores at boot.
		Tested on mt6589 by Matthias.
mt6580-smp:     Only first core is alive at boot, so need to wakeup
		other cores using SPM. AFAIK only for mt6580 now.
mt81xx-tz-smp:  For soc which wakeup all cores at boot, and have
		trustzone firmware. Suitable for mt8127, mt8135.

I'm not sure about smp for mt6592, maybe Howard or Scott can comment on
it.

Any suggestion on how we should organize these methods?

Joe.C
