From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 11:03:00 +0800
Subject: [PATCH 6/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-polaroid-mid2407pxe03
In-Reply-To: <1470685398-14568-6-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-6-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67bg9mLB0Ga9Ro+Lv=rYgb8DtHQiKXxwbE6L1CWyZcbOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 9, 2016 at 3:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a node enabling the gsl1680 touchscreen controller found on
> sun8i-a23-polaroid-mid2407pxe03 tablets.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
> index e300442..cd64fd61 100644
> --- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
> +++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
> @@ -48,3 +48,20 @@
>         model = "Polaroid MID2407PXE03 tablet";
>         compatible = "polaroid,mid2407pxe03", "allwinner,sun8i-a23";
>  };
> +
> +&gsl1680 {
> +       touchscreen-size-x = <960>;
> +       touchscreen-size-y = <640>;
> +       touchscreen-inverted-x;
> +       touchscreen-inverted-y;
> +       touchscreen-fw-name = "silead/gsl1680-polaroid-mid2407pxe03.fw";
> +       status = "okay";
> +};
> +
> +&reg_ldo_io1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "vcc-touchscreen";
> +       status = "okay";
> +};

This looks good, but it would be better if the touchscreen node
took the regulator as a supply.

Regards
ChenYu
