From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 09:41:37 +0200
Subject: [PATCH] ARM: dts: add hdmi regulators for exynos5800 based
 peach-pi board
In-Reply-To: <1403760382-12533-1-git-send-email-rahul.sharma@samsung.com>
References: <1403760382-12533-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CABxcv=ncVTiFX+YYguyk0XJDC6WTYnvJeivzf-4wOLwETmzK9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rahul,

On Thu, Jun 26, 2014 at 7:26 AM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> Adding regulators for HDMI for exynos5800 based Peach-pi board.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
> Based on Kukjin's for-next branch.
> Depends on:
> 1) PMIC addition to Peach-pi: http://www.spinics.net/lists/linux-samsung-soc/msg33166.html
> 2) tps65090 addition to Peach-pi: http://www.spinics.net/lists/linux-samsung-soc/msg32464.html
>
>  arch/arm/boot/dts/exynos5800-peach-pi.dts |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 2c2c137..30d1a26 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -127,6 +127,10 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&hdmi_hpd_irq>;
>         ddc = <&i2c_2>;
> +       hdmi-en-supply = <&tps65090_fet7>;
> +       vdd-supply = <&ldo8_reg>;
> +       vdd_osc-supply = <&ldo10_reg>;
> +       vdd_pll-supply = <&ldo8_reg>;

You had a line break between the ddc and the supplies on your patch
for Peach pit, can you please add it here as well?

I think that is more readable and also we may later factor out common
DTS fragments on these two boards in .dtsi include files so is better
to keep the diff as small as possible.

>  };
>
>  &hsi2c_7 {
> --
> 1.7.9.5
>

With that trivial change:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
