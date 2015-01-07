From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Jan 2015 15:34:20 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <20150107095936.GG7853@lukather>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150106155705.GB23784@lunn.ch> <20150106173101.GB7853@lukather>
 <20150106180757.GC25030@lunn.ch> <20150107095936.GG7853@lukather>
Message-ID: <20150107143420.GA30268@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > > +			i2c0: i2c at 11000 {
> > > > > +				pinctrl-names = "default";
> > > > > +				pinctrl-0 = <&i2c0_pins>;
> > > > > +				status = "okay";
> > > > > +				clock-frequency = <100000>;
> > > > > +			};
> > > > > +
> > > > > +			i2c1: i2c at 11100 {
> > > > > +				status = "okay";
> > > > > +				clock-frequency = <100000>;
> > > > > +			};
> > > > 
> > > > Is there anything on these two i2c busses?
> > > 
> > > One goes to some pin of the mPCIe slot, the other is connected to the
> > > EEPROM.
> > 
> > So could you add the EEPROM, and a comment about the mPCIe slot?
> 
> I can't really add the EEPROM: it actually goes to two DIP sockets,
> one of them holding that EEPROM, the other one being empty.
> 
> The default EEPROM also contains the board ID, that will be used by
> the bootloader. Erasing this will result in a board that can't be
> booted, so I'm not really sure exposing it to the user is a good idea.

O.K, please add a comment. People like me tend to run i2c-detect to
see if there is anything interesting on the bus. A warning you can
brick the board could save somebody an interesting time.

      Andrew
