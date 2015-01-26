From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jan 2015 11:09:21 +0100
Subject: [PATCH] ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board
In-Reply-To: <20150126003520.GA871@cartman.at.offog.org>
References: <1422199921-325-1-git-send-email-ats@offog.org>
 <20150125164846.GL8470@lukather>
 <20150126003520.GA871@cartman.at.offog.org>
Message-ID: <20150126100921.GQ8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 12:35:20AM +0000, Adam Sampson wrote:
> Hi Maxime,
> 
> On Sun, Jan 25, 2015 at 05:48:46PM +0100, Maxime Ripard wrote:
> > > +			label = "pcduino3-nano:green:led3";
> ...
> > > +			label = "pcduino3-nano:green:led4";
> > Where are the three other leds?
> 
> LED1 is the power LED, and as far as I can see there isn't an LED2 on
> the board. LED5 is next to LED3/4, but it's not exposed by the 3.4
> kernel that LinkSprite ship, and this forum post says it's not
> software-controllable (which seems weird):
> http://forum.linksprite.com/index.php?/topic/3145-pcduino3-nano-led-control/
> 
> > Also, usually, the last part of the label is what the led function
> > usually is.
> 
> "LED3" and "LED4" are how those LEDs are actually labelled on the board
> (unlike the pcDuino v3, which labels them "TX" and "RX", and calls them
> pcduino3:green:rx/tx in the DTS). I've changed them to
> pcduino3-nano:led3:usr and pcduino3-nano:led4:usr, but if you've got any
> better suggestions then please let me know!

It depends on what the leds are used for, but this is not what the
label should be either.

If you read Documentation/leds/leds-class.txt, the pattern to follow is:

"devicename:colour:function"

so it should rather be pcduino3-nano:green:usr1 and usr2, or some
other thing.

> > > +&uart0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart0_pins_a>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&uart2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart2_pins_a>;
> > > +	status = "okay";
> > > +};
> > 
> > You probably want aliases for these two UARTs.
> 
> Done: I've aliased serial0 = &uart0 and serial1 = &uart2. Should there
> be aliases for I2C as well, since the same situation applies (i2c0 and
> i2c2)?

Yep.

> More generally, is it correct to add nodes like these (uart2, spi0,
> i2c2) for features that appear on the Arduino GPIO headers?

If those pins are specifically dedicated to this feature, then yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/f9329746/attachment.sig>
