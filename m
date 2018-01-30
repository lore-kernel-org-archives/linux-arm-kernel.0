From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 09:40:16 +0100
Subject: [PATCH v5 5/6] arm: dts: sun8i: a83t: bananapi-m3: Enable IR
 controller
In-Reply-To: <20180129155810.7867-6-embed3d@gmail.com>
References: <20180129155810.7867-1-embed3d@gmail.com>
 <20180129155810.7867-6-embed3d@gmail.com>
Message-ID: <20180130084016.4uyrd425qpzyiyql@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 04:58:09PM +0100, Philipp Rossak wrote:
> The Bananapi M3 has an onboard IR receiver.
> This enables the onboard IR receiver subnode.
> Unlike the other IR receivers this one needs a base clock frequency
> of 3000000 Hz (3 MHz), to be able to work.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> index 6550bf0e594b..ffc6445fd281 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> @@ -82,6 +82,13 @@
>  	};
>  };
>  
> +&cir {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cir_pins>;

If this is the only muxing option (like your node name suggests), you
can put it directly in the DTSI to remove boilerplate from all the
DTS.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/356dff44/attachment.sig>
