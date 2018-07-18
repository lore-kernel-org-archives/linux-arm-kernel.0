From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jul 2018 11:57:52 +0200
Subject: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
In-Reply-To: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
> Add missing GIC interrupts property for pwm nodes.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 5d2f0a0..9406108 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -169,6 +169,11 @@
>                 pwm: pwm at 12dd0000 {
>                         compatible = "samsung,exynos4210-pwm";
>                         reg = <0x12DD0000 0x100>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,

Indentation here looks weird - spaces used after tabs but not aligned
with first entry. Please indent it properly and align it.

Best regards,
Krzysztof

> +                                  <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>                         samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>                         #pwm-cells = <3>;
>                 };
> --
> 2.7.4
>
