From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Aug 2014 19:12:08 +0200
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140808171208.GC26751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 12:18:52PM -0300, Ezequiel Garcia wrote:
> This commit adds the required pin muxing for the network interfaces and
> the MDIO interface to be properly initialized. For instance, this makes
> it possible for a bootloader to initialize and access the network interfaces.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-mirabox.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
> index 097df7d8..c745256 100644
> --- a/arch/arm/boot/dts/armada-370-mirabox.dts
> +++ b/arch/arm/boot/dts/armada-370-mirabox.dts
> @@ -91,6 +91,8 @@
>  			};
>  
>  			mdio {
> +				pinctrl-0 = <&mdio_pins>;
> +				pinctrl-names = "default";
>  				phy0: ethernet-phy at 0 {
>  					reg = <0>;
>  				};
> @@ -100,11 +102,15 @@
>  				};
>  			};
>  			ethernet at 70000 {
> +				pinctrl-0 = <&ge0_pins>;
> +				pinctrl-names = "default";

Hi Ezequiel

Could you put these one level higher in the DT hierarchy? i.e. once in
armada-370.dtsi and not in every board .dts file?

	Andrew
