From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 14 Aug 2016 22:24:13 +0200 (CEST)
Subject: [PATCH 1/3] ARM: dts: skeleton: Fix build warning with W=1
In-Reply-To: <1471203266-30414-1-git-send-email-festevam@gmail.com>
References: <1471203266-30414-1-git-send-email-festevam@gmail.com>
Message-ID: <69819507.278199.5842a41f-9d6d-4b55-baac-1529d6cae164.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 14. August 2016 um 21:34
> geschrieben:
> 
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Fix the following build warnings with W=1:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but
> no unit name

according to this thread [1] this patch shouldn't be applied yet. Patch 2 and 3
are okay.

Btw: Do you have any comments about this patch series [2]?

[1] -
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/418430.html
[2] - http://marc.info/?l=linux-arm-kernel&m=147048830916087

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/skeleton.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
> index b41d241..a20da0a 100644
> --- a/arch/arm/boot/dts/skeleton.dtsi
> +++ b/arch/arm/boot/dts/skeleton.dtsi
> @@ -9,5 +9,5 @@
>  	#size-cells = <1>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; reg = <0 0>; };
> +	memory at 0 { device_type = "memory"; reg = <0 0>; };
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
