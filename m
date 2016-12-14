From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Dec 2016 09:55:47 +0100
Subject: [PATCH linux v1 4/4] arm: dts: Add dt-binding to support seven
 segment display on zaius
In-Reply-To: <1481702104-8617-5-git-send-email-jaghu@google.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-5-git-send-email-jaghu@google.com>
Message-ID: <3917905.e4iOqADnVQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 13, 2016 11:55:04 PM CET Jaghathiswari Rankappagounder Natarajan wrote:
> Add clock, data and clear signal GPIO lines to control seven segment display on
> zaius platform.
> 
> Signed-off-by: Jaghathiswari Rankappagounder Natarajan <jaghu@google.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> index 8ef4ece..ccb8147 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> @@ -43,6 +43,14 @@
>  			gpios = <&gpio ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	seven-seg-disp {
> +		compatible = "seven-seg-gpio-dev";
> +		refresh-interval-ms = "1000";
> +		clock-gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_HIGH>;
> +		data-gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
> +		clear-gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
> +	};
>  };


According to your introductory mail, the interface is assumed to be
a 74HC164. Should we use that ID in the compatible string?

We can always add other strings later if we want to support multiple
wire formats.

	Arnd
