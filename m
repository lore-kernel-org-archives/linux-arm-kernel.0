From: w@1wt.eu (Willy Tarreau)
Date: Sun, 12 Feb 2017 01:53:50 +0100
Subject: [PATCH] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <20170212004031.GA7328@lunn.ch>
References: <1486805073-15534-1-git-send-email-w@1wt.eu>
 <20170212004031.GA7328@lunn.ch>
Message-ID: <20170212005350.GA18612@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sun, Feb 12, 2017 at 01:40:31AM +0100, Andrew Lunn wrote:
> > +			serial at 12000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&uart0_pins>;
> > +				status = "okay";
> > +			};
> > +
> > +			serial at 12100 {
> > +				/* A PIC16F1829 is connected to uart1 at 115200 bps,
> > +				 * and takes single-character orders :
> > +				 *   "1" : power off
> 
> Hi Willy
> 
> The qnap-poweroff.c driver will support this. You need a new
> compatible string, since 115200 is not the speed the current synology
> devices use.

But won't that squat the I/O address and prevent me from using all the
other codes via the regular serial port ? They are particularly convenient
in fact since they are the only way to access the LEDs, beeper and even
to trigger a reset (even if this last one is less used in software form).

> > +				 *   "2" : short beep
> > +				 *   "3" : long beep
> > +				 *   "4" : turn the power LED ON
> > +				 *   "5" : flash the power LED
> > +				 *   "6" : turn the power LED OFF
> > +				 *   "7" : turn the status LED OFF
> > +				 *   "8" : turn the status LED ON
> > +				 *   "9" : flash the status LED
> > +				 *   "A" : flash the motherboard LED (D8)
> > +				 *   "B" : turn the motherboard LED OFF
> > +				 *   "C" : hard reset
> > +				 */
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&uart1_pins>;
> > +				status = "okay";
> > +			};
> 
> > +		gpio-leds {
> > +			compatible = "gpio-leds";
> > +
> > +			/* The greed part is on gpio0.20 which is also used by
> 
> green?

Oops, sorry, thanks for catching.

Willy
