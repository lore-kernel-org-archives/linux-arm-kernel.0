From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Feb 2013 19:58:12 +0100
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <20130208213441.014343E2C27@localhost>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <20130208213441.014343E2C27@localhost>
Message-ID: <20130210185812.GI20212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +* QNAP Power Off
> > +
> > +QNAP NAS devices have a microcontroller controlling the main power
> > +supply. This microcontroller is connected to UART1 of the Kirkwood and
> > +Orion5x SoCs. Sending the charactor 'A', at 19200 baud, tells the
> > +microcontroller to turn the power off. This driver adds a handler to
> > +pm_power_off which is called to turn the power off.
> > +
> > +Required Properties:
> > +- compatibile: Should be "qnap,power-off"
> 
> It would do well to have the model number embedded into this compatible
> string since it is unlikely that every single QNAP device will use the
> same controller interface.

Hi Grant

All QNAP devices known to mainline use this same controller interface.

So that would be ts109, ts209, ts409, ts119, ts219, ts419, plus a few
other models which we don't differentiate, like ts219P and ts219P+.

Any suggestions what to use in the compatible string?

    Thanks
	Andrew
