From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 11:03:29 +0200
Subject: [PATCH 2/3] ARM: sun8i: a83t: Drop leading zeroes from device
 node addresses
In-Reply-To: <20170418042205.27894-3-wens@csie.org>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-3-wens@csie.org>
Message-ID: <20170418090329.odixwybrkqvp2o7z@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:22:04PM +0800, Chen-Yu Tsai wrote:
> Kbuild now complains about leading zeroes in the address portion of
> device node names.
> 
> Get rid of them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 913aacafe8d5..82cb87f21b96 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -162,7 +162,7 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		pio: pinctrl at 01c20800 {
> +		pio: pinctrl at 1c20800 {

As far as I know this breaks Uboot's auto-addition of stdout-path

Maxime
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/8e60df3b/attachment.sig>
