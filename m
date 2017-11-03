From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Nov 2017 17:44:45 +0000
Subject: SDP4430 nightly regression (was: Re: [GIT PULL] two omap
 regression fixes)
In-Reply-To: <20171103172648.GI28152@atomide.com>
References: <pull-1509652473-291160@atomide.com>
 <20171103104316.GE28231@n2100.armlinux.org.uk>
 <20171103160518.GG28152@atomide.com>
 <20171103172648.GI28152@atomide.com>
Message-ID: <20171103174444.GF28231@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 10:26:48AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [171103 16:07]:
> > * Russell King - ARM Linux <linux@armlinux.org.uk> [171103 10:45]:
> > > In the diffstat between the two build trees (post merge), I don't see
> > > anything in arch/arm that could account for it.  I do see some power
> > > changes:
> > > 
> > >  drivers/base/power/domain_governor.c               |  53 +--
> > >  drivers/base/power/qos.c                           |   2 +-
> > >  drivers/base/power/runtime.c                       |   2 +-
> > >  drivers/base/power/sysfs.c                         |  25 +-
> > > 
> > > but nothing in tty or serial.  These power changes look like QoS
> > > changes, which probably aren't related.
> > > 
> > > Just to make sure, I've diffed the build tree SHAs and the change in
> > > Linus' tip, and the two diffs match apart from a couple of SHA blob
> > > hashes on a couple of files (EFI stub and MAINTAINERS).
> > 
> > Initiating git bisect sequence.
> 
> Seems this is now fixed in the mainline kernel. I also confirmed
> that v4.14-rc6 fails to resume. Most likely Rafael's revert of
> the following two commits fixed the issue:
> 
> 5ba257249e9c ("Revert "PM / QoS: Fix default runtime_pm device resume latency"")
> d5919dcc349d ("Revert "PM / QoS: Fix device resume latency PM QoS"")

Thanks.  The nightly builder should build 3a99df9a3d14 as Linus'
tip plus all the other bits tonight.  I won't have any time tomorrow
to look at the results though.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
