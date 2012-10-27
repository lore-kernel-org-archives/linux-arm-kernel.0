From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Oct 2012 11:11:43 +0200
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310
In-Reply-To: <alpine.DEB.2.02.1210261857100.20029@mirri>
References: <alpine.DEB.2.02.1210251735020.15860@mirri>
 <20121025181326.GL18811@titan.lakedaemon.net>
 <alpine.DEB.2.02.1210261857100.20029@mirri>
Message-ID: <20121027091143.GD15143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +
> > > +static struct i2c_board_info __initdata nsa310_i2c_info[] = {
> > > +	{ I2C_BOARD_INFO("adt7476", 0x2e) },
> > > +};
> > 
> > how far off from the adt7461 (lm90) is this?  If similar, please
> > consider extending lm90's compatibility list and describing this in the
> > dts instead.
> 
> I did move at least the I2C to DT. Good catch, this is something 
> worth of a experimentation when a free time slot arrives. The chip seems 
> to have some sort of compatibility mode with adt7463 so it might just 
> work somehow with the other driver too.

Hi Tero

Thanks for moving the I2C bus setup to DT.

The lm90 driver explicitly supports the adt7461. No changes needed. Please
try adding the necessary DT, something like:

                        adt7476: adt7476a at 2e {
                                compatible = "lm90";
                                reg = <0x2e>;
                        };

    Thanks

        Andrew
