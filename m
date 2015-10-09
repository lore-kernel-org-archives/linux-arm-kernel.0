From: robherring2@gmail.com (Rob Herring)
Date: Fri, 9 Oct 2015 08:10:15 -0500
Subject: [PATCH 3/4] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <1444365376-10728-4-git-send-email-leo.yan@linaro.org>
References: <1444365376-10728-1-git-send-email-leo.yan@linaro.org>
 <1444365376-10728-4-git-send-email-leo.yan@linaro.org>
Message-ID: <CAL_Jsq+XzFEUUURZ_z3fygjZtDmDYUgx6uKn2hYrAu32s-vhuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 11:36 PM, Leo Yan <leo.yan@linaro.org> wrote:
> Add sp804 timer for hi6220, so it can be used as broadcast timer.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 3f03380..7edbe42 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -167,5 +167,14 @@
>                         clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
>                         clock-names = "uartclk", "apb_pclk";
>                 };
> +
> +               dual_timer0: dual_timer at f8008000 {
> +                       compatible = "arm,sp804", "arm,primecell";
> +                       reg = <0x0 0xf8008000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ao_ctrl 27>, <&ao_ctrl 27>;
> +                       clock-names = "apb_pclk", "apb_pclk";

These should not have the same name and should be 3 clocks. The
binding doc is not clear what the names should be, but follow the
example.

The vexpress-v2p-ca9, hi3620 and hip04 are wrong too (in different ways).

Rob

> +               };
>         };
>  };
> --
> 1.9.1
>
