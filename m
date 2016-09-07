From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Sep 2016 13:08:23 -0700
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxbb: Add Meson MHU Node
In-Reply-To: <1471515027-3543-4-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 18 Aug 2016 12:10:27 +0200")
References: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com>
 <1471515027-3543-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hwpinscaw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied,

Kevin

> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index e502c24..bdbf6e7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -321,6 +321,15 @@
>  				#clock-cells = <1>;
>  				reg = <0x0 0x0 0x0 0x3db>;
>  			};
> +
> +			mailbox: mailbox at 404 {
> +				compatible = "amlogic,meson-gxbb-mhu";
> +				reg = <0 0x404 0 0x4c>;
> +				interrupts = <0 208 IRQ_TYPE_EDGE_RISING>,
> +					     <0 209 IRQ_TYPE_EDGE_RISING>,
> +					     <0 210 IRQ_TYPE_EDGE_RISING>;
> +				#mbox-cells = <1>;
> +			};
>  		};
>  
>  		apb: apb at d0000000 {
