From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Dec 2016 15:09:34 +0100
Subject: [PATCH] ARM: dts: sunxi: Change node name for pwrseq pin on
 Olinuxino-lime2-emmc
In-Reply-To: <20161214100856.23735-1-manu@bidouilliste.com>
References: <20161214100856.23735-1-manu@bidouilliste.com>
Message-ID: <20161214140934.zdztogdjjis23raw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emmanuel,

On Wed, Dec 14, 2016 at 11:08:56AM +0100, Emmanuel Vadot wrote:
> The node name for the power seq pin is mmc2 at 0 like the mmc2_pins_a one.
> This makes the original node (mmc2_pins_a) scrapped out of the dtb and
> result in a unusable eMMC if U-Boot didn't configured the pins to the
> correct functions.
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> index 5ea4915..68cb1b5 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> @@ -56,7 +56,7 @@
>  };
>  
>  &pio {
> -	mmc2_pins_nrst: mmc2 at 0 {
> +	mmc2_pins_nrst: mmc2 at 1 {

That would be even better if you renamed it to something like
mmc2-rst-pin to avoid all future conflicts (for example if we ever add
a second mmc pins groups.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/a7d1b197/attachment-0001.sig>
