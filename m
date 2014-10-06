From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 13:01:43 +0200
Subject: [PATCH v7 11/11] ARM: at91/dt: enable the LCD panel on
 sama5d3xek boards
In-Reply-To: <1412175188-28278-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-12-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141006110142.GI25202@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 04:53:08PM +0200, Boris Brezillon wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> Enable LCD related nodes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/boot/dts/sama5d31ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d33ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d34ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d36ek.dts | 20 ++++++++++++++++++++
>  4 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
> index 04eec0d..6e605fe 100644
> --- a/arch/arm/boot/dts/sama5d31ek.dts
> +++ b/arch/arm/boot/dts/sama5d31ek.dts
> @@ -33,6 +33,10 @@
>  				status = "okay";
>  			};
>  
> +			hlcdc: hlcdc at f0030000 {
> +				status = "okay";
> +			};
> +
>  			macb1: ethernet at f802c000 {
>  				status = "okay";
>  			};
> @@ -46,6 +50,22 @@
>  		};
>  	};
>  
> +	bl_reg: backlight_regulator {

No need to repeat the labels if they're already in the .dtsi file.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/d999c3e6/attachment.sig>
