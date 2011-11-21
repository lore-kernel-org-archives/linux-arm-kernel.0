From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 21 Nov 2011 14:47:46 +0000
Subject: [PATCH] Initial DT support for SIMpad devices.
In-Reply-To: <4ECA6118.1050806@scram.de>
References: <1321821470-32396-1-git-send-email-jochen@scram.de>
 <20111121095020.GA7314@totoro> <4ECA6118.1050806@scram.de>
Message-ID: <20111121144746.GB25627@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jochen,

On Mon, Nov 21, 2011 at 03:32:56PM +0100, Jochen Friedrich wrote:
> >>+	localbus {
> >>+		compatible = "intel,sa1110-localbus";
> >
> >Could this claim compatibility with simple-bus?
> 
> I wasn't sure about this. I took a look in the powerpc DTS files for reference and they used
> some kind of <chip>-localbus compatible entries. So I took the same approach here.

Hmm, I haven't seen any of the ARM platforms doing this, and unless the 
sa1110 bus has some extra knobs that need tweaking, then simple-bus 
should be fine.

> >>+		uart2: serial at 0x80050000 {
> >>+			compatible = "intel,sa1100-uart";
> >>+			reg =<0x80050000 0x24>;
> >>+			interrupts =<17>;
> >>+			status = "disabled";
> >
> >Hmm, I couldn't see status defined in the UART binding or where it was
> >used...  Is this required?
> 
> status is a global property and it's being used in drivers/of/base.c, of_device_is_available().
> It is used in other dtsi files like e.g. at91sam9g45.dtsi as well to define optional nodes.

Ahh, I wasn't aware of that one - thanks!

> >>+/ {
> >>+	model = "SIEMENS, SIMpad";
> >>+	compatible = "siemens,simpad";
> >
> >It may be worth adding the SoC compatible string after the board one for
> >completeness.
> 
> Do you mean something like this?
> 
> 	compatible = "siemens,simpad", "intel,sa1100";

Yup, that looks about right.

> >>+	chosen {
> >>+		bootargs = "console=ttySA0";
> >
> >It is preferred for the bootloader to set these up rather than having
> >them statically in the DTS if at all possible.
> 
> Yes, my boot loader does this, but simpad support is not in official U-BOOT yet.
> This allows testing with a different boot loader like the hh.org one and a Linux
> binary with DTB appended.

OK, I guess that's fair enough, though I certainly shouldn't be 
considered an authoritative source on this!

Jamie
