From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 Aug 2013 13:04:57 -0500
Subject: [PATCH v3 2/2] ARM: dts: msm: Update uartdm compatible strings
In-Reply-To: <1377648764-23453-3-git-send-email-sboyd@codeaurora.org>
References: <1377648764-23453-1-git-send-email-sboyd@codeaurora.org>
 <1377648764-23453-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <0092782E-9E89-4350-B3B5-EB1275F2F8E3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 27, 2013, at 7:12 PM, Stephen Boyd wrote:

> Let's follow the ratified DT binding and use uartdm instead of
> hsuart. This does break backwards compatibility but this
> shouldn't be a problem because the uart driver isn't probing on
> these devices without adding clock support (which isn't merged so
> far).

I'm not seeing any driver upstream even using the compatibles so might be worth adding that we aren't even breaking anything upstream.

Otherwise you can add:

Acked-by: Kumar Gala <galak@codeaurora.org>

> 
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> arch/arm/boot/dts/msm8660-surf.dts | 2 +-
> arch/arm/boot/dts/msm8960-cdp.dts  | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
> index cdc010e..386d428 100644
> --- a/arch/arm/boot/dts/msm8660-surf.dts
> +++ b/arch/arm/boot/dts/msm8660-surf.dts
> @@ -38,7 +38,7 @@
> 	};
> 
> 	serial at 19c40000 {
> -		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> +		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> 		reg = <0x19c40000 0x1000>,
> 		      <0x19c00000 0x1000>;
> 		interrupts = <0 195 0x0>;
> diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
> index db2060c..532050b 100644
> --- a/arch/arm/boot/dts/msm8960-cdp.dts
> +++ b/arch/arm/boot/dts/msm8960-cdp.dts
> @@ -38,7 +38,7 @@
> 	};
> 
> 	serial at 16440000 {
> -		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> +		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> 		reg = <0x16440000 0x1000>,
> 		      <0x16400000 0x1000>;
> 		interrupts = <0 154 0x0>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
