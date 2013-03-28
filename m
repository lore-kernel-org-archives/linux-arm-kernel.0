From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 28 Mar 2013 00:38:08 -0300
Subject: [PATCH] ARM: mvebu: Add gpio button to Mirabox board
In-Reply-To: <CABx3TkVyVAzEJ54FV70fK3BoULKCOkgNcw32_K3XT-oCUWjEfg@mail.gmail.com>
References: <CABx3TkVyVAzEJ54FV70fK3BoULKCOkgNcw32_K3XT-oCUWjEfg@mail.gmail.com>
Message-ID: <20130328033807.GA12212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On Wed, Mar 27, 2013 at 05:42:36PM -0700, Ryan Press wrote:
> Ezequiel Garcia wrote:
> >
> >The Globalscale Mirabox board has a little gpio button
> >placed just above the SD card slot; the board user guide labels
> >this button as "System reset button".
> >
> >This patch adds support for this button in the device tree file.
> >diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
> >+		gpio-keys {
> >+			compatible = "gpio-keys";
> >+			#address-cells = <1>;
> >+			#size-cells = <0>;
> >+			reset at 1 {
> >+				label = "Reset Button";
> >+				linux,code = <116>;
> >+				gpios = <&gpio1 26 1>;
> 
> Were you able to get the button to work in user space with
> "gpio-keys"?

I did a very minimal test using evdev debug interface.

http://troll.ws/paste/ac62e292
http://troll.ws/paste/b22699e1

> I was not able to get this to work, I think there is
> some IRQ problem.  I was able to get it to work with
> "gpio-keys-polled" however.
> 

Could you explain what you did and what was your problem?

> I've also added support for the LEDs; would you like me to submit a patch?
> 

Mirabox LEDs? Sure! I'll definitely give them a try...

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
