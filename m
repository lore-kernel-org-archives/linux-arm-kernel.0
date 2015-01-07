From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jan 2015 10:59:36 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <20150106180757.GC25030@lunn.ch>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150106155705.GB23784@lunn.ch> <20150106173101.GB7853@lukather>
 <20150106180757.GC25030@lunn.ch>
Message-ID: <20150107095936.GG7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 07:07:57PM +0100, Andrew Lunn wrote:
> > > Maybe add
> > > 
> > > stdout-path = &uart1;
> > 
> > Does that even work with the 8250? Last time I tried with a 3.18, it
> > didn't, and you still needed the console= bootargs.
> 
> It is for the bootloader, not Linux. barebox will use this, etc.  I
> think there are also plans for linux to use this. Not sure how far it
> has got.

Ok.

> > > > +			i2c0: i2c at 11000 {
> > > > +				pinctrl-names = "default";
> > > > +				pinctrl-0 = <&i2c0_pins>;
> > > > +				status = "okay";
> > > > +				clock-frequency = <100000>;
> > > > +			};
> > > > +
> > > > +			i2c1: i2c at 11100 {
> > > > +				status = "okay";
> > > > +				clock-frequency = <100000>;
> > > > +			};
> > > 
> > > Is there anything on these two i2c busses?
> > 
> > One goes to some pin of the mPCIe slot, the other is connected to the
> > EEPROM.
> 
> So could you add the EEPROM, and a comment about the mPCIe slot?

I can't really add the EEPROM: it actually goes to two DIP sockets,
one of them holding that EEPROM, the other one being empty.

The default EEPROM also contains the board ID, that will be used by
the bootloader. Erasing this will result in a board that can't be
booted, so I'm not really sure exposing it to the user is a good idea.

> > > If not, why enable them and increase the clock speed?
> > 
> > The clock speed is not increased, it's actually the driver's default.
> 
> Dio you need this then? Is it in the dtsi file?

That got fixed recently by Chen-Yu, I guess we don't need it anymore.

> 
> > > > +			uart0: serial at 12000 {
> > > > +				pinctrl-names = "default";
> > > > +				pinctrl-0 = <&uart0_pins>;
> > > > +				status = "okay";
> > > > +			};
> > > > +
> > > > +			uart1: serial at 12100 {
> > > > +				pinctrl-names = "default";
> > > > +				pinctrl-0 = <&uart1_pins>;
> > > > +				status = "okay";
> > > > +			};
> > > 
> > > If it is not obvious from the silk screen, could you describe which
> > > connector this uart is on, what pins are what?
> > 
> > There's two UART connectors documented in the user guide (JP8 and
> > JP9). UART1 is also connected to a FTDI chip, that is exposed through
> > a mini-USB connector.
> 
> I'm guessing the user guide is only available under NDA?

It appears so yes.

> Where as you can get the hardware without an NDA. At least i have a
> 370-rd, but no NDA. So some minimal documentation would be
> nice. Especially since it is backwards around to what most people
> would expect.

Ok, I'll add a comment.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/533dd591/attachment.sig>
