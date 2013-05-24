From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 24 May 2013 10:08:07 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <519E5732.1040800@free-electrons.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <201305221305.09579.marex@denx.de> <201305230920.18200.jbe@pengutronix.de>
 <201305231648.17356.marex@denx.de>
 <1369322904.4142.36.camel@weser.hi.pengutronix.de>
 <519E5732.1040800@free-electrons.com>
Message-ID: <1369382887.4117.34.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 23.05.2013, 19:51 +0200 schrieb Alexandre Belloni:
> Hi,
> 
[...]
> >
> > So while we _might_ be able to get the PIO mode to work on the i.MX23
> > there is nothing in the doc stating that it's even meant to work. Even
> > while PIO and DMA mode use the same internal mechanisms, there's still
> > plenty of opportunities of fail in there. After all PIO mode relies on
> > reading a debug register in the course of normal operation.
> >
> > Only more extensive experimentation could show if we are in fact able to
> > make it work, a first shot of using PIO mode on MX23 failed, so it might
> > as well be that Juergens quick fix is correct and we have to disable PIO
> > mode on MX23 altogether. That said please stop slapping the word "hack"
> > over this patch until proven otherwise.
> 
> Still, Fabio and I have been experiencing the one second delay on
> i.mx28. From my experience, it appeared between 3.7 and 3.9, see:
> http://www.spinics.net/lists/linux-i2c/msg11985.html. I still didn't
> take the time to investigate more yet but it confirms that PIO mode is
> working on i.mx28 though with an annoying delay.
> 

Just for the record: I know that PIO mode is functional on i.MX28
because I have it working on one of our customer boards. I am rather
much surprised it's still not working well for you, but haven't had a
chance to investigate yet. The i.MX28 RM explicitly describes how to
work with the PIO mode, so if it's not working this is bug somewhere.

This thread/patch is about a whole different problem, namely PIO mode
being non-functional on i.MX23. As the i.MX23 RM doesn't describe the
PIO mode, there is no indication that it's even meant to work on this
chip.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
