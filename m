From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:50:34 +0100
Subject: [PATCH v2 13/16] arm: dts: sun8i: h3: add thermal zone to H3
In-Reply-To: <20180128232919.12639-14-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-14-embed3d@gmail.com>
Message-ID: <20180129095034.5crx7ydq5k6f7omv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 12:29:16AM +0100, Philipp Rossak wrote:
> This patch adds the thermal zones to the H3. We have only one sensor and
> that is placed in the cpu.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index fbb007e5798e..3f83f6a27c74 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,15 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			/* milliseconds */
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 0>;

if the thermal-sensor-cells value is indeed 0, the phandle parsing
will be broken here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/3a1a5204/attachment-0001.sig>
