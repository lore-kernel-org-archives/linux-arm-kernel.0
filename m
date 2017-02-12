From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 12 Feb 2017 01:40:31 +0100
Subject: [PATCH] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <1486805073-15534-1-git-send-email-w@1wt.eu>
References: <1486805073-15534-1-git-send-email-w@1wt.eu>
Message-ID: <20170212004031.GA7328@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +			serial at 12000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart0_pins>;
> +				status = "okay";
> +			};
> +
> +			serial at 12100 {
> +				/* A PIC16F1829 is connected to uart1 at 115200 bps,
> +				 * and takes single-character orders :
> +				 *   "1" : power off

Hi Willy

The qnap-poweroff.c driver will support this. You need a new
compatible string, since 115200 is not the speed the current synology
devices use.

> +				 *   "2" : short beep
> +				 *   "3" : long beep
> +				 *   "4" : turn the power LED ON
> +				 *   "5" : flash the power LED
> +				 *   "6" : turn the power LED OFF
> +				 *   "7" : turn the status LED OFF
> +				 *   "8" : turn the status LED ON
> +				 *   "9" : flash the status LED
> +				 *   "A" : flash the motherboard LED (D8)
> +				 *   "B" : turn the motherboard LED OFF
> +				 *   "C" : hard reset
> +				 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart1_pins>;
> +				status = "okay";
> +			};

> +		gpio-leds {
> +			compatible = "gpio-leds";
> +
> +			/* The greed part is on gpio0.20 which is also used by

green?


Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
