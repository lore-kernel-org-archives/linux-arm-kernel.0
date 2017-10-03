From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 3 Oct 2017 13:25:55 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: Rename SBC to DragonBoard 410c
In-Reply-To: <20171003091155.7138-2-linus.walleij@linaro.org>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
 <20171003091155.7138-2-linus.walleij@linaro.org>
Message-ID: <b6b065c7-ad6b-d3da-704f-f139f12752d8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/17 10:11, Linus Walleij wrote:
> Naming the DragonBoard 410c "SBC" (I guess "single board computer")
> is not very helpful for users looking for their device tree in
> the kernel. Also the db820c is named properly.
> 
> Rectify this, simply, do not change the compatible strings but name
> the DTS files in a consistent manner.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I did not like the sbc naming convention too, This was primarily done 
due to some legacy build tools + bootloaders which have used sbc 
compatible to identify boards from multiple dtb blobs. Now that we can 
append dtb to kernel with new LK, this should not be a issue anymore.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> It's not like I don't understand that people will be nitpicky
> about this.
> 
> I was looking for the DragonBoard 410c devicetree and could not
> find it until I realized this hopeless idiomatic naming.
> 
> It cost me time and effort, and it is going to cost others time
> and effort. Fixing it.
> 
> The other patch naming the GPIO lines can be applied without
> this one.
> ---
>   arch/arm64/boot/dts/qcom/Makefile                                    | 2 +-
>   .../{apq8016-sbc-pmic-pins.dtsi => apq8016-db410c-pmic-pins.dtsi}    | 0
>   .../qcom/{apq8016-sbc-soc-pins.dtsi => apq8016-db410c-soc-pins.dtsi} | 0
>   arch/arm64/boot/dts/qcom/{apq8016-sbc.dts => apq8016-db410c.dts}     | 5 +++--
>   arch/arm64/boot/dts/qcom/{apq8016-sbc.dtsi => apq8016-db410c.dtsi}   | 4 ++--
>   5 files changed, 6 insertions(+), 5 deletions(-)
>   rename arch/arm64/boot/dts/qcom/{apq8016-sbc-pmic-pins.dtsi => apq8016-db410c-pmic-pins.dtsi} (100%)
>   rename arch/arm64/boot/dts/qcom/{apq8016-sbc-soc-pins.dtsi => apq8016-db410c-soc-pins.dtsi} (100%)
>   rename arch/arm64/boot/dts/qcom/{apq8016-sbc.dts => apq8016-db410c.dts} (95%)
>   rename arch/arm64/boot/dts/qcom/{apq8016-sbc.dtsi => apq8016-db410c.dtsi} (99%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index ff81d7e5805e..fc46ab79acd9 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-db410c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-db410c-pmic-pins.dtsi
> similarity index 100%
> rename from arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
> rename to arch/arm64/boot/dts/qcom/apq8016-db410c-pmic-pins.dtsi
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-db410c-soc-pins.dtsi
> similarity index 100%
> rename from arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
> rename to arch/arm64/boot/dts/qcom/apq8016-db410c-soc-pins.dtsi
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-db410c.dts
> similarity index 95%
> rename from arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> rename to arch/arm64/boot/dts/qcom/apq8016-db410c.dts
> index 40b0d62861bb..86cfae4d2b9d 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-db410c.dts
> @@ -13,10 +13,11 @@
>   
>   /dts-v1/;
>   
> -#include "apq8016-sbc.dtsi"
> +#include "apq8016-db410c.dtsi"
>   
>   / {
> -	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
> +	model = "Qualcomm Technologies, Inc. APQ 8016 DragonBoard 410c";
> +	/* The "SBC" (Single Board Computer) is another name for this board */
>   	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
>   };
>   
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-db410c.dtsi
> similarity index 99%
> rename from arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> rename to arch/arm64/boot/dts/qcom/apq8016-db410c.dtsi
> index 1d63e6b879de..1300c11e5f0e 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-db410c.dtsi
> @@ -13,8 +13,8 @@
>   
>   #include "msm8916.dtsi"
>   #include "pm8916.dtsi"
> -#include "apq8016-sbc-soc-pins.dtsi"
> -#include "apq8016-sbc-pmic-pins.dtsi"
> +#include "apq8016-db410c-soc-pins.dtsi"
> +#include "apq8016-db410c-pmic-pins.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
>   #include <dt-bindings/sound/apq8016-lpass.h>
> 
