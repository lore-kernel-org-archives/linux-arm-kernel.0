From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 10:56:39 +0200
Subject: [PATCH 2/3] arm64: allwinner: dts: h6: add pinmux for MMC1
In-Reply-To: <20180724011551.49603-3-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
 <20180724011551.49603-3-icenowy@aosc.io>
Message-ID: <20180724085639.2cebno52qfxrzmdw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:15:50AM +0800, Icenowy Zheng wrote:
> The MMC1 controller on H6, in the reference design and most third party
> design, is used to connect SDIO Wi-Fi.
> 
> Add pinmux for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index cfa5fffcf62b..ba1a3a3e2149 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -134,6 +134,14 @@
>  				bias-pull-up;
>  			};
>  
> +			mmc1_pins: mmc1-pins {
> +				pins = "PG0", "PG1", "PG2", "PG3",
> +				       "PG4", "PG5";
> +				function = "mmc1";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +

Is that the sole muxing option for MMC1? If so, it should be added to
the mmc1 node.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/75b96958/attachment.sig>
