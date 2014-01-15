From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 19:20:22 +0100
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <20140115174519.GE17530@lunn.ch>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <201401151736.46280.arnd@arndb.de> <20140115174519.GE17530@lunn.ch>
Message-ID: <4773460.bSrjnYju7q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 18:45:19 Andrew Lunn wrote:
> > > But i'm also a little bit concerned by the "unique number" and this
> > > ending up in /dev/input/by-path/platform-gpio_keys.3-event. Is this
> > > path supposed to be stable? This unique number is not stable. An
> > > unwitting change to the DT could cause its value to change. Do we need
> > > to make it stable?
> > > 
> > 
> > One possibility would be to create an artificial bus in DT for all
> > gpio-keys devices, use #address-cells=<1> and #size-cells=<0>
> > for it, and give each device a unique reg property. Not sure if that
> > would be considered an elegant solution though.
> 
> Hi Arnd
> 
> Can i imply from your answer that you think 
> 
> /dev/input/by-path/platform-gpio_keys.3-event
> 
> should be stable?

No, I have no idea whether it should be or not. I was just trying
to come up with a way to make it stable if that's desired.

> A quick look at udev rules seems to suggestion this is an issue for
> input/gpio-keys and maybe audio and video if there is a top level DT
> property collecting the different sub devices together for ASOC and
> V4L.

For some other subsystems, we have entries in /aliases/ to sort
them. Maybe that would work here to get a stable path independent
of the location in DT.

	Arnd
