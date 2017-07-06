From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Jul 2017 20:52:05 +0200
Subject: [PATCH] ARM: sunxi: h3/h5: Correct emac register size
In-Reply-To: <20170706085334.25380-1-clabbe.montjoie@gmail.com>
References: <20170706085334.25380-1-clabbe.montjoie@gmail.com>
Message-ID: <20170706185205.f4jwskpnz4d3udvv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 10:53:34AM +0200, Corentin Labbe wrote:
> The datasheet said that emac register size is 0x1000 not 0x104
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 716e7d668dec..5a57b67c9b77 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -406,7 +406,7 @@
>  		emac: ethernet at 1c30000 {
>  			compatible = "allwinner,sun8i-h3-emac";
>  			syscon = <&syscon>;
> -			reg = <0x01c30000 0x104>;
> +			reg = <0x01c30000 0x1000>;

The size is actually 0x10000. I fixed it and applied.

The A64 DTSI has the same issue, can you send a patch for this one
too?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/599ce217/attachment.sig>
