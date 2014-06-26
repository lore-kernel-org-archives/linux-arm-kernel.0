From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 09:34:32 +0200
Subject: [PATCH] ARM: dts: add hdmi regulators for exynos5420 based
 peach-pit board
In-Reply-To: <1403099099-6599-1-git-send-email-rahul.sharma@samsung.com>
References: <1403099099-6599-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CABxcv=n0Fu8c3wWsHuAbzbfaQEF0Gc-vO_TBsgf_w4Ng2yg_ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rahul,

On Wed, Jun 18, 2014 at 3:44 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> Adding regulators for hdmi for peach-pit board.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
> Based on for-next branch in Kukjin's tree.
> Dependent on:
> 1) PMIC DT patch at http://www.gossamer-threads.com/lists/linux/kernel/1945703
> 2) tps65090 DT patch at https://lkml.org/lkml/2014/6/13/483
>
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 1c5b8f9..0a6a1cb 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -229,6 +229,11 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&hdmi_hpd_irq>;
>         ddc = <&i2c_2>;
> +
> +       hdmi-en-supply = <&tps65090_fet7>;
> +       vdd-supply = <&ldo8_reg>;
> +       vdd_osc-supply = <&ldo10_reg>;
> +       vdd_pll-supply = <&ldo8_reg>;
>  };
>
>  &usbdrd_phy0 {
> --
> 1l.7.9.5
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
