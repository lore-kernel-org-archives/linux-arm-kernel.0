From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Apr 2017 14:39:08 +0200
Subject: [PATCH v4 08/18] arm: sun8i: orangepi-pc: Enable dwmac-sun8i
In-Reply-To: <20170412111400.2296-9-clabbe.montjoie@gmail.com>
References: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
 <20170412111400.2296-9-clabbe.montjoie@gmail.com>
Message-ID: <20170412123908.vho6eodh4p3t7fry@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Wed, Apr 12, 2017 at 01:13:50PM +0200, Corentin Labbe wrote:
> The dwmac-sun8i hardware is present on the Orange PI PC.
> It uses the internal PHY.
> 
> This patch create the needed emac node.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> index f148111..746c25a 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> @@ -53,6 +53,7 @@
>  
>  	aliases {
>  		serial0 = &uart0;
> +		ethernet0 = &emac;

Sorry for not spotting this earlier...

This should be ordered by alphabetical order, 

>  	};
>  
>  	chosen {
> @@ -184,3 +185,10 @@
>  	/* USB VBUS is always on */
>  	status = "okay";
>  };
> +
> +&emac {
> +	phy-handle = <&int_mii_phy>;
> +	phy-mode = "mii";
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};

And the node here as well.

Almost all your other DT patches also have this issue, please fix it
in all of them.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/36268261/attachment.sig>
