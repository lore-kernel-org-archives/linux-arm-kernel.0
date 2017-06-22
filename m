From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Jun 2017 08:16:17 +0200
Subject: [PATCH v1] ARM: dts: sun7i: provide ramoops region on BananaPi
In-Reply-To: <1498065017-30556-1-git-send-email-linux@rempel-privat.de>
References: <1498065017-30556-1-git-send-email-linux@rempel-privat.de>
Message-ID: <20170622061617.5guhcyxdthvmiq7j@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

On Wed, Jun 21, 2017 at 07:10:17PM +0200, Oleksij Rempel wrote:
> This should help provide useful debug information on remote
> targets without UART.
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index ed2f35a..38923bf 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -63,6 +63,22 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		ramoops at 7fb6a000 {
> +			compatible = "ramoops";
> +			reg = <0x7fb6a000 0x100000>;
> +			ecc-size	= <16>;
> +			record-size	= <0x00020000>;
> +			console-size	= <0x00020000>;
> +			ftrace-size	= <0x00020000>;
> +			pmsg-size	= <0x00020000>;
> +		};
> +	};
> +

I'm a bit skeptical about this one.

First, there's nothing specific to the bananapi, but every one will
want to have different sizes here, or different parameters.

Since using the kernel parameters is also an option, I'd rather
document how to do that with the parameters.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170622/6df87a31/attachment.sig>
