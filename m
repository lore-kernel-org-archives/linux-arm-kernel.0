From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:41:26 +0200
Subject: [PATCH v2 10/18] arm64: dts: allwinner: a64: Orange Pi Win: Mark
 CPU supply regulator
In-Reply-To: <20180726003532.18751-11-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-11-andre.przywara@arm.com>
Message-ID: <20180726074126.cjizfiyk4pi2iypg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:35:24AM +0100, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> DCDC2 (polyphased with DCDC3) is supplying the power to the CPU.
> Add a property to the CPU node to mark this connection.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 6f85a05d2f4b..ec24b7379d6d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -101,6 +101,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +

I'd rather not do that. As soon as we'll have OPPs in the DTSI, that
means that cpufreq will be enabled on that board, while no one ever
tested it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/f3a4d26f/attachment-0001.sig>
