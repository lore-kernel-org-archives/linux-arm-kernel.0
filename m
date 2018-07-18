From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jul 2018 15:55:57 +0200
Subject: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
In-Reply-To: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
References: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPdAEp-7jw-AqPfmqq+ygY_p4BGt92voCNRc3z57KU_-ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2018 at 14:59, Anand Moon <linux.amoon@gmail.com> wrote:
> Add missing GIC interrupts property for pwm nodes.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fixed the patch indentation issue with all tabs.
> sorry checkpatch could not figure out the error.
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 5d2f0a0..f48fb9b 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -169,6 +169,11 @@
>                 pwm: pwm at 12dd0000 {
>                         compatible = "samsung,exynos4210-pwm";
>                         reg = <0x12DD0000 0x100>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;

OK, thanks for v2. Now only tabs are used but in previous mail I
mentioned which example to use - the rtc node which nicely aligns
continued lines. Why you did not follow this alignment?

I'll fix it when applying, no need to resend.

Best regards,
Krzysztof
