From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2011 08:26:50 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
	<20110529215656.GA5576@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
Message-ID: <20110531072650.GC21382@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 10:05:38PM -0700, David Rientjes wrote:
> On Sun, 29 May 2011, Russell King - ARM Linux wrote:
> > Again, no.  This change has caused a load of previously working drivers
> > to suddenly start failing without _any_ explanation why or even warning
> > about the change.  It needs to start off as a WARN_ON() so that stuff
> > can be fixed, and then changed to a hard error.
> > 
> 
> I haven't seen a "load" of error reports where this is causing an issue, 
> maybe it is much more popular on arm?
> 
> This also isn't a hard error, admins should be able to enable 
> CONFIG_ZONE_DMA and rebuild so that the driver being loaded can get the 
> type of memory it is requesting.  Just putting a WARN_ON() doesn't provide 
> any incentive to ever get this stuff fixed.

I completely and violently disagree with your approach on this, and I'll
continue to state that I believe you are wrong until you change your
position.

Enabling CONFIG_ZONE_DMA is not a fix, it's making the problem vanish off
the radar.  It will mean that the drivers using GFP_DMA will never get
fixed up.

I don't care whether you say "it's easy enough to audit the source code" -
who's going to do that work?  If you make the problem go away the answer
to that will be NO ONE.

Change it to be a soft WARN_ON for one release.  Anything else will just
result in the problem being IGNORED.
