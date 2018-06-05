From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 5 Jun 2018 21:09:09 +0200
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
In-Reply-To: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 10:52 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> devices on the P212 Reference Design based boards.
>
> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

out of curiosity: I guess you tested this using u-boot?
if anyone else is interested: the only other way to test this is by
ensuring that the hdmi_5v regulator is turned off by Linux (by
removing it from the HDMI nodes) and then plugging in a USB device ->
if it doesn't get VBUS then the hdmi_5v regulator is the cause (and
needs to be kept/turned on by the USB code, just like Neil's patch
does)

> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 0cfd701..a1b3101 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -189,3 +189,10 @@
>  &usb0 {
>         status = "okay";
>  };
> +
> +&usb2_phy0 {
> +       /*
> +        * HDMI_5V is also used as supply for the USB VBUS.
> +        */
> +       phy-supply = <&hdmi_5v>;
> +};
> --
> 2.7.4
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
