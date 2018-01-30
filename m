From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 09:38:32 +0100
Subject: [PATCH v4 3/6] arm: dts: sun8i: a83t: Add the cir pin for the A83T
In-Reply-To: <20180129155810.7867-4-embed3d@gmail.com>
References: <20180129155810.7867-1-embed3d@gmail.com>
 <20180129155810.7867-4-embed3d@gmail.com>
Message-ID: <20180130083832.hkcivcyrko3s7xku@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Mon, Jan 29, 2018 at 04:58:07PM +0100, Philipp Rossak wrote:
> The CIR Pin of the A83T is located at PL12.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index de5119a2a91c..06e96db7c41a 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -617,6 +617,11 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			cir_pins: cir-pins at 0 {
> +				pins = "PL12";
> +				function = "s_cir_rx";
> +			};
> +

Sorry for not noticing this earlier, but this should be r_cir_pin, and
you should drop the unit-address that generates a dtc warning.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/8199bc1d/attachment.sig>
