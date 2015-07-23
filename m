From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 23 Jul 2015 17:19:02 +0900
Subject: [PATCH] PM / devfreq: event: Remove incorrect property in
 exynos-ppmu DT binding
In-Reply-To: <1436770732-9430-1-git-send-email-javier@osg.samsung.com>
References: <1436770732-9430-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55B0A376.2080906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 07/13/2015 03:58 PM, Javier Martinez Canillas wrote:
> The exynos-ppmu driver is only a clock consumer and not a clock provider
> but its Device Tree binding listed #clock-cells as an optional property.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index b54bf3a2ff57..aed486692880 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -17,7 +17,6 @@ Required properties:
>  Optional properties:
>  - clock-names : the name of clock used by the PPMU, "ppmu"
>  - clocks : phandles for clock specified in "clock-names" property
> -- #clock-cells: should be 1.
>  
>  Example1 : PPMU nodes in exynos3250.dtsi are listed below.
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

+ Devfreq maintainer (Myungjoo Ham)
I think that this patch will be more appropriate on devfreq git tree
than linux-samsung git tree.

Thanks,
Chanwoo Choi
