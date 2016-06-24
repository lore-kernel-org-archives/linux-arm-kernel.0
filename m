From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 10:41:41 +0800
Subject: [PATCH 01/14] ARM: dts: sun8i: Add SID node
In-Reply-To: <20160623192104.18720-2-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-2-megous@megous.com>
Message-ID: <CAGb2v677+abNOEg3iEoiH25Ji9tq0JXkrGUVvLPAbXAPD3Su_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
> From: Josef Gajdusek <atx@atx.name>
>
> Add a node describing the Security ID memory to the Allwinner H3 .dtsi file.
>
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 4a4926b..172576d 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -389,6 +389,13 @@
>                         #size-cells = <0>;
>                 };
>
> +               sid: eeprom at 01c14000 {
> +                       compatible = "allwinner,sun4i-a10-sid";

This has been discussed before. The hardware is not compatible.
The write control registers are at different offsets.

ChenYu

> +                       reg = <0x01c14000 0x400>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +               };
> +
>                 usbphy: phy at 01c19400 {
>                         compatible = "allwinner,sun8i-h3-usb-phy";
>                         reg = <0x01c19400 0x2c>,
> --
> 2.9.0
>
