From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Oct 2013 18:02:13 +0200
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 104 board
In-Reply-To: <20131021215746.GF23593@lunn.ch>
References: <87txgapcas.fsf@natisbad.org>
 <20131021215746.GF23593@lunn.ch>
Message-ID: <20131022160213.GB26694@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +			pinctrl {
> > +				poweroff: poweroff {
> > +					marvell,pins = "mpp60";
> > +					marvell,function = "gpio";
> > +				};
> > +
> > +				backup_key_pin: backup-key-pin {
> > +					marvell,pins = "mpp52";
> > +					marvell,function = "gpio";
> > +				};
> > +
> > +				power_key_pin: power-key-pin {
> > +					marvell,pins = "mpp62";
> > +					marvell,function = "gpio";
> > +				};
> > +
> > +				backup_led_pin: backup-led-pin {
> > +					marvell,pins = "mpp63";
> > +					marvell,function = "gpo";
> > +				};
> > +
> > +				power_led_pin: power-led-pin {
> > +					marvell,pins = "mpp64";
> > +					marvell,function = "gpio";
> > +				};
> > +
> > +				reset_key_pin: reset-key-pin {
> > +					marvell,pins = "mpp65";
> > +					marvell,function = "gpio";
> > +				};
> > +			};
> 
> You can also skip these. The gpio driver will put the pin into gpio
> mode when the leds/keys driver claims it. It is a case of, i didn't
> know that, put entries like this into a number of files, and people
> have been copying my mistake ever since. Thomas made an effort to
> correct this for some boards.

Thomas just talked to me about this. What i said is right, but wrong.

It is correct they are not required. The gpio driver and pinctrl will
do the right thing without these. However, having these entries is
good because it improves what you see in /debugfs/pinctrl. There is a
name in the output. So please do keep these entries, and sorry for the
noise.

	Andrew
