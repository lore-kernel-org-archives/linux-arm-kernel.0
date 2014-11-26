From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Nov 2014 10:19:35 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126172857.GA26157@amd>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141126172857.GA26157@amd>
Message-ID: <20141126181934.GL2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [141126 09:31]:
> On Tue 2014-10-28 01:01:38, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > > +
> > > +	if (!of_have_populated_dt())
> > > +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > > +
> > 
> > Maybe use WARN so that the warning is more verbose and kernel gets tainted?
> 
> Well.. Pali still has regression where /proc/cpuinfo changes in a way
> that breaks existing userspace, when dt is used on N900.
> 
> And rmk was less then helpfull...

Maybe Pali can try to restart that discussion? To me it seems the
/proc/cpuinfo should be the same as it's a user interface. Sorry
forgot the details of the previous discussion..

And with which app was that? Sorry I forgot..

It's weird that it's not been an issue for other though? 
 
> Should we maybe solve that before adding backtraces to our boot
> messages?

With this warning we want to notify the people actually using
mainline kernel on omap3 that they should update their systems.
And also let us know on this list about the regressions, so I
think that's quite valuable.

Regards,

Tony
