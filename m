From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Feb 2014 20:47:03 +0100
Subject: [PATCH 6/6] arm: dts: am335x beagle bone use processor macids
In-Reply-To: <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
Message-ID: <20140213194703.GG17650@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 18, 2013 at 05:47:22PM +0100, Markus Pargmann wrote:
> Use macids stored in the am335x chip.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/am335x-bone.dts      | 8 ++++++++
>  arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 94ee427..9b65a62 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -10,6 +10,14 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  
> +&cpsw_emac0 {
> +	ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
> +};
> +
> +&cpsw_emac1 {
> +	ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
> +};
with the mac-address property overwriting the addresses found in the
mac-address-ctrl block as I suggested in reply to the respective patch,
I'd add this property not per machine but directly in am33xx.dtsi.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
