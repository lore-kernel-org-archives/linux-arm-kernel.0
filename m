From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 25 Mar 2016 16:17:30 -0700
Subject: [PATCH V7 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <1453197766-18976-6-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <CAJAp7Oi33=kraAiU337JdFJZbuKZEVoCtY4FfAv_RgiWVmz+sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 2:02 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 753bdfd..7786408 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1,6 +1,6 @@
>  /dts-v1/;
>
> -#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8974.h>
>  #include "skeleton.dtsi"
>
> @@ -345,6 +345,16 @@
>                         interrupt-controller;
>                         #interrupt-cells = <4>;
>                 };
> +
> +               blsp2_dma: dma-controller at f9944000 {
> +                       compatible = "qcom,bam-v1.4.0";
> +                       reg = <0xf9944000 0x19000>;
> +                       interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> +                       clock-names = "bam_clk";
> +                       #dma-cells = <1>;
> +                       qcom,ee = <0>;

Without "qcom,bam_ctrl_remote;" and
https://patchwork.kernel.org/patch/8639181/ the Xperia Honami board
fails to boot with this patch included.

> +               };
>         };
>

Regards,
Bjorn
