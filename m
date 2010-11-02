From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 02 Nov 2010 11:19:06 +0200
Subject: [PATCH 0/2] OMAP: DSS2: Add new display panel
In-Reply-To: <AANLkTi=fV58ApDqUE21YMK0_vhLdPbPr7F7YpYh0-2Vc@mail.gmail.com>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
	<1288620930.5614.16.camel@tubuntu>
	<AANLkTi=fV58ApDqUE21YMK0_vhLdPbPr7F7YpYh0-2Vc@mail.gmail.com>
Message-ID: <1288689546.5614.60.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-01 at 17:45 +0100, ext Bryan Wu wrote:
> On Mon, Nov 1, 2010 at 10:15 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:

> > What we need is a common driver for all these dummy panels, and the
> > driver would contain configurations for all the supported panels. The
> > board file would pass the name of the panel used in that board to the
> > driver, and the driver would use the configurations for that panel.
> >
> 
> It looks like that we just need one file name displays.c to do those
> generic things and pass the configuration from board files to this
> driver, such as timing or other things.

Not quite. If you pass timing information from the board files then
every board file has to define all the timings, even if they are using
the same panel.

That's why the configs should be in the panel driver, and the board file
only has to define which panel is actually connected.

> > This has been discussed a few times in l-o list, but I haven't found
> > time to implement it and nobody else has done it either.
> >
> 
> I'm quite happy to do this, thanks,

Thanks, I appreciate that.

 Tomi
