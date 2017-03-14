From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 14 Mar 2017 11:20:31 -0700
Subject: [PATCH v2 16/20] ARM: dts: sun50i-a64: enable dwmac-sun8i on
 pine64
In-Reply-To: <20170314141856.24560-17-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
 <20170314141856.24560-17-clabbe.montjoie@gmail.com>
Message-ID: <6fd5818c-94ad-ae1b-2caf-ca657a2f1066@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2017 07:18 AM, Corentin Labbe wrote:
> The dwmac-sun8i hardware is present on the pine64
> It uses an external PHY via RMII.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index c680ed3..b53994d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -109,3 +109,18 @@
>  &usbphy {
>  	status = "okay";
>  };
> +
> +&mdio {
> +	ext_rmii_phy1: ethernet-phy at 1 {
> +	      reg = <1>;

Even though it's optional, it's nice to have a:

	compatible = "ethernet-phy-ieee802.3-c22"

string here.

This applies to all DTS files that you have in subsequent patches.

Thanks!
-- 
Florian
