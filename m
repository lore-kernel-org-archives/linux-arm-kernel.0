From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Feb 2014 20:34:31 +0100
Subject: [PATCH v3 2/8] ARM: dts: sun7i: Add GMAC clock node to sun7i DTSI
In-Reply-To: <1391398346-5094-3-git-send-email-wens@csie.org>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
 <1391398346-5094-3-git-send-email-wens@csie.org>
Message-ID: <20140203193431.GD25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 11:32:20AM +0800, Chen-Yu Tsai wrote:
> The GMAC uses 1 of 2 sources for its transmit clock, depending on the
> PHY interface mode. Add both sources as dummy clocks, and as parents
> to the GMAC clock node.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 1595e9a..fc7f470 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -314,6 +314,34 @@
>  		};
>  
>  		/*
> +		 * The following two are dummy clocks, placeholders used
> +		 * on gmac_tx clock. The actual frequency and availability
> +		 * depends on the external PHY, operation mode and link
> +		 * speed.
> +		 */

If it depends on the external PHY, I guess that means it also depends
on the board, right? Or is the GMAC supposed to always have that clock
running at 25MHz, no matter what PHY is connected to it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140203/7297c745/attachment.sig>
