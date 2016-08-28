From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:29:39 +0200
Subject: [PATCH v3 3/4] ARM64: dts: meson-gxbb: Add Meson GXBB PWM
 Controller nodes
In-Reply-To: <1471880193-21879-4-git-send-email-narmstrong@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCDBPgrHsDuPLV=4MTFLZn10DmXM8FR171W9g3SoZUJ9aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index e502c24..e3f4d36 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -153,6 +153,27 @@
>                                 status = "disabled";
>                         };
>
> +                       pwm_ab: pwm at 8550 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x08550 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
> +
> +                       pwm_cd: pwm at 8650 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x08650 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
> +
> +                       pwm_ef: pwm at 86c0 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x086c0 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
I have successfully tested pwm_e on my meson-gxbb-vega-s95-meta clone
(see [0] for the corresponding patches), thus:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[0] https://github.com/xdarklight/linux/tree/meson-gxbb-integration-4.8-20160828
