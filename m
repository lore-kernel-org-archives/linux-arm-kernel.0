From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 17:51:41 -0700
Subject: [PATCH 1/2] ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
In-Reply-To: <1476775534-4493-1-git-send-email-linus.walleij@linaro.org>
References: <1476775534-4493-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161019005141.GT8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18, Linus Walleij wrote:
> This adds the external bus interface EBI2 to the MSM8660 device
> tree, albeit with status = "disabled" so that devices actually
> using EBI2 can turn it on if needed.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Rebase on kernel v4.9-rc1
> - Bindings and driver are merged so should be clear to apply.
> ChangeLog v2->v3:
> - Use the new #address-cells = <2> for indicating the CS in the
>   first address cell
> - Use the ranges property properly for defining the six different
>   CS address windows
> - Define CS3 to properly map over 128MB
> - The EBI2 bindings are now ACKed by Rob Herring and a pull request
>   to ARM SoC for both binding and driver is pending.
> - This should be safe to merge for v4.9
> ---
>  arch/arm/boot/dts/qcom-msm8660.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index 8c65e0d82559..0b6348544598 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -141,6 +141,23 @@
>  			};
>  		};
>  
> +		ebi2 at 1a100000 {

Perhaps the node name should be more generic, like

external-bus at 1a100000

? I know, bikeshedding...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
