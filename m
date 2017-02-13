From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Feb 2017 10:16:12 +0100
Subject: [PATCH 2/8] ARM: sun4i: Add display blocks for the sun4i dtsi.
In-Reply-To: <20170211174405.28395-3-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
 <20170211174405.28395-3-plaes@plaes.org>
Message-ID: <20170213091612.d5ifc4oi63xf7boi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 11, 2017 at 07:43:59PM +0200, Priit Laes wrote:
> Added basic display pipeline consisting of tcon, display backend and
> frontend blocks.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index ba20b48..70991c9 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -779,6 +779,45 @@
>  			#size-cells = <0>;
>  		};
>  
> +		tcon0: lcd-controller at 1c0c000 {
> +			compatible = "allwinner,sun5i-a13-tcon";

There's a few bits here and there that need to be setup differently in
A10, so you cannot reuse that compatible (same thing for the other).

Also, I'd really like to have all the blocks listed here, and not only
the first pipeline. Ideally, on the A10, the two pipelines should be
enabled too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/f23f38dd/attachment.sig>
