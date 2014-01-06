From: bcousson@baylibre.com (Benoit Cousson)
Date: Mon, 06 Jan 2014 23:43:23 +0100
Subject: [PATCH] ARM: dts: omap3430-sdp: add dip switch information for
 MMC operation
In-Reply-To: <1389047853-26375-1-git-send-email-nm@ti.com>
References: <1389047853-26375-1-git-send-email-nm@ti.com>
Message-ID: <52CB318B.4030603@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 06/01/2014 23:37, Nishanth Menon wrote:
> MMC 8 bit mode operation depends on dip switch setting which is not
> obvious - The current board file has this description. However, with
> removal of the board file in the future, this information will be lost
> and has to be rediscovered.

Thanks for that. I've just applied it.

Regards,
Benoit


> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/boot/dts/omap3430-sdp.dts |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
> index 281914e..cd3d047 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -34,6 +34,10 @@
>   &mmc1 {
>   	vmmc-supply = <&vmmc1>;
>   	vmmc_aux-supply = <&vsim>;
> +	/*
> +	 * S6-3 must be in ON position for 8 bit mode to function
> +	 * Else, use 4 bit mode
> +	 */
>   	bus-width = <8>;
>   };

-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
