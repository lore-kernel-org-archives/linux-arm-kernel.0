From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Apr 2017 14:41:53 +0200
Subject: [PATCH v4 13/18] arm64: allwinner: sun50i-a64: add dwmac-sun8i
 Ethernet driver
In-Reply-To: <20170412111400.2296-14-clabbe.montjoie@gmail.com>
References: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
 <20170412111400.2296-14-clabbe.montjoie@gmail.com>
Message-ID: <20170412124153.q6zvdvqkroizaxgb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 01:13:55PM +0200, Corentin Labbe wrote:
> The dwmac-sun8i is an Ethernet MAC that supports 10/100/1000 Mbit
> connections. It is very similar to the device found in the Allwinner
> H3, but lacks the internal 100 Mbit PHY and its associated control
> bits.
> This adds the necessary bits to the Allwinner A64 SoC .dtsi, but keeps
> it disabled at this level.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 0b0f4ab..2569827 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -287,6 +287,23 @@
>  				bias-pull-up;
>  			};
>  
> +			rmii_pins: rmii_pins {
> +				pins = "PD10", "PD11", "PD13", "PD14",
> +						"PD17", "PD18", "PD19", "PD20",
> +						"PD22", "PD23";

Please align the wrapped lines on the first pin.

> +				function = "emac";
> +				drive-strength = <40>;

Do you actually need that for all the boards, or only a few of them?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/24b56b06/attachment.sig>
