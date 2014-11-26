From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 26 Nov 2014 18:28:57 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141027230138.GB7805@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
Message-ID: <20141126172857.GA26157@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-10-28 01:01:38, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > +
> > +	if (!of_have_populated_dt())
> > +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > +
> 
> Maybe use WARN so that the warning is more verbose and kernel gets tainted?

Well.. Pali still has regression where /proc/cpuinfo changes in a way
that breaks existing userspace, when dt is used on N900.

And rmk was less then helpfull...

Should we maybe solve that before adding backtraces to our boot
messages?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
