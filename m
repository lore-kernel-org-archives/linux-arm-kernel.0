From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 12:02:05 +0200
Subject: [RFC] ARM: vt8500: cleanup start
In-Reply-To: <CAJ3iQcqvaCbFJ0V4ZJ_cDxA1TN=JemaghUJQgVO_LkEq=DYjbg@mail.gmail.com>
References: <CAJ3iQco9qu8Z7Gm0AtcvV3OPc6C39Hdqjq6tVKMYy5qV2=ASwA@mail.gmail.com>
 <5016910.Qn6QdqhQ4L@wuerfel>
 <CAJ3iQcqvaCbFJ0V4ZJ_cDxA1TN=JemaghUJQgVO_LkEq=DYjbg@mail.gmail.com>
Message-ID: <4258201.EByetKsPpX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 17:32:26 Gergely Imreh wrote:
> > > https://github.com/viaembedded/arm-soc/tree/via-header
> > >
> > > Should this be part of a larger patchset later on, or is it okay just
> > > to send any time like
> > > this? Are these changes worth doing if the functionality itself did
> > > not really change,
> > > just probably the style improves?
> >
> > I think a good start would be to split out the reset code into a
> > proper device driver. The register used for reset is part of the
> > "pmc" device that is used in the clock driver, so you can
> > add a reboot/poweroff handler there and register it with arm_pm_restart/
> > pm_power_off.
> >
> 
> I guess the examples for these that I could see are the ones in
> drivers/power/reset? Or is there a driver that does this well that
> you'd recommend learning from?

Most of them seem pretty reasonable actually

> I've seen that in drivers/power/reset there's a bunch of X-reset.c,
> X-poweroff.c, X-reboot.c: any actual pattern to these files/naming?

I think some drivers can only reboot and some can only power off.
No idea which name is preferred for a driver that does both.

	Arnd
