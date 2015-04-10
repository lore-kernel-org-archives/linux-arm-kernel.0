From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 10:24:59 -0700
Subject: [PATCH v2 05/12] ARM: dts: apq8064: Add SATA controller support.
In-Reply-To: <1428669263-10990-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428669263-10990-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5528076B.1010808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/15 05:34, Srinivas Kandagatla wrote:
> This patch adds AHCI based SATA controller support to APQ8064.
> Tested on IFC6410 board.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  9 ++++++++
>  arch/arm/boot/dts/qcom-apq8064.dtsi        | 35 ++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 122bf34..c9c9c5e 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -116,6 +116,15 @@
>  			};
>  		};
>  
> +		sata_phy0: sata-phy at 1b400000{

Space before '{' please.

> +			status = "okay";
> +		};
> +
> +		sata0: sata at 29000000 {
> +			status		= "okay";
> +			target-supply	= <&pm8921_s4>;
> +		};
> +
>  		/* OTG */
>  		usb1_phy: phy at 12500000 {
>  			status		= "okay";
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 5aac9a5..56cc65e 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -379,6 +379,41 @@
>  			usb-phy		= <&usb4_phy>;
>  		};
>  
> +		sata_phy0: sata-phy at 1b400000{

Space before '{' please. Also I wonder if it should just be called
phy at 1b400000 because phy is more standard than sata-phy.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
