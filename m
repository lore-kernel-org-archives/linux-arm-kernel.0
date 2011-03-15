From: James.Bottomley@suse.de (James Bottomley)
Date: Tue, 15 Mar 2011 07:50:28 -0400
Subject: [Security] [PATCH 00/20] world-writable files in sysfs and debugfs
In-Reply-To: <20110315030956.GA2234@kroah.com>
References: <cover.1296818921.git.segoon@openwall.com>
	<AANLkTikE-A=Fe-yRrN0opWwJGQ0f4uOzkyB3XCcEUrFE@mail.gmail.com>
	<1300155965.5665.15.camel@mulgrave.site>
	<20110315030956.GA2234@kroah.com>
Message-ID: <1300189828.4017.2.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-03-14 at 20:09 -0700, Greg KH wrote:
> On Mon, Mar 14, 2011 at 10:26:05PM -0400, James Bottomley wrote:
> > On Sat, 2011-03-12 at 23:23 +0300, Vasiliy Kulikov wrote:
> > > > Vasiliy Kulikov (20):
> > > >  mach-ux500: mbox-db5500: world-writable sysfs fifo file
> > > >  leds: lp5521: world-writable sysfs engine* files
> > > >  leds: lp5523: world-writable engine* sysfs files
> > > >  misc: ep93xx_pwm: world-writable sysfs files
> > > >  rtc: rtc-ds1511: world-writable sysfs nvram file
> > > >  scsi: aic94xx: world-writable sysfs update_bios file
> > > >  scsi: iscsi: world-writable sysfs priv_sess file
> > > 
> > > These are still not merged :(
> > 
> > OK, so I've not been tracking where we are in the dizzying ride on
> > security systems.  However, I thought we landed up in the privilege
> > separation arena using capabilities.  That means that world writeable
> > files aren't necessarily a problem as long as the correct capabilities
> > checks are in place, right?
> 
> There are no capability checks on sysfs files right now, so these all
> need to be fixed.

That statement is true but irrelevant, isn't it?  There can't be
capabilities within sysfs files because the system that does them has no
idea what the capabilities would be.  If there were capabilities checks,
they'd have to be in the implementing routines.

I think the questions are twofold:

     1. Did anyone actually check for capabilities before assuming world
        writeable files were wrong?
     2. Even if there aren't any capabilities checks in the implementing
        routines, should there be (are we going the separated
        capabilities route vs the monolithic root route)?

James
