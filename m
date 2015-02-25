From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 25 Feb 2015 12:36:11 -0600
Subject: [PATCH] ARM: dts: am335x-boneblack: enable aes and sham
In-Reply-To: <1424884070-25891-1-git-send-email-mporter@konsulko.com>
References: <1424884070-25891-1-git-send-email-mporter@konsulko.com>
Message-ID: <CAOCHtYju0ZPV-BZS=L5S+JUX4gcRkJwqUZQBuURgGMo_Nmqt7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:07 AM, Matt Porter <mporter@konsulko.com> wrote:
> Beaglebone Black doesn't have AES and SHAM enabled like the
> original Beaglebone White dts. This breaks applications that
> leverage the crypto blocks so fix this by enabling these nodes.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 5c42d25..00853ff 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -33,6 +33,14 @@
>         status = "okay";
>  };
>
> +&sham {
> +       status = "okay";
> +};
> +
> +&aes {
> +       status = "okay";
> +};
> +
>  &am33xx_pinmux {
>         nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
>                 pinctrl-single,pins = <
> --
> 1.8.4

Shouldn't we just move these to: "am335x-bone-common.dtsi" ?

(and then nuke the 6 lines in the am335x-bone.dts )

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
