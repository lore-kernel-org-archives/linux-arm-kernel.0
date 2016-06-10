From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Jun 2016 21:32:59 +0200
Subject: [PATCH 3/3] ARM: dts: BCM5310x: Enable switch ports on SmartRG
 SR400AC
In-Reply-To: <1465583756-26740-4-git-send-email-f.fainelli@gmail.com>
References: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
 <1465583756-26740-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160610193259.GI2338@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 11:35:56AM -0700, Florian Fainelli wrote:
> Define the port mapping for the SmartRG SR400ACE device.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 8b0c440b2e71..c219d33496cc 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -126,3 +126,43 @@
>  &spi_nor {
>  	status = "okay";
>  };
> +
> +&srab {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		switch0port0: port at 0 {

Hi Florian

You don't need the labels, since you don't have any phandles pointing
at them.

Other than that, great to see a board using the new switch driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
