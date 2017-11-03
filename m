From: tony@atomide.com (Tony Lindgren)
Date: Fri, 3 Nov 2017 10:26:48 -0700
Subject: SDP4430 nightly regression (was: Re: [GIT PULL] two omap
 regression fixes)
In-Reply-To: <20171103160518.GG28152@atomide.com>
References: <pull-1509652473-291160@atomide.com>
 <20171103104316.GE28231@n2100.armlinux.org.uk>
 <20171103160518.GG28152@atomide.com>
Message-ID: <20171103172648.GI28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [171103 16:07]:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [171103 10:45]:
> > In the diffstat between the two build trees (post merge), I don't see
> > anything in arch/arm that could account for it.  I do see some power
> > changes:
> > 
> >  drivers/base/power/domain_governor.c               |  53 +--
> >  drivers/base/power/qos.c                           |   2 +-
> >  drivers/base/power/runtime.c                       |   2 +-
> >  drivers/base/power/sysfs.c                         |  25 +-
> > 
> > but nothing in tty or serial.  These power changes look like QoS
> > changes, which probably aren't related.
> > 
> > Just to make sure, I've diffed the build tree SHAs and the change in
> > Linus' tip, and the two diffs match apart from a couple of SHA blob
> > hashes on a couple of files (EFI stub and MAINTAINERS).
> 
> Initiating git bisect sequence.

Seems this is now fixed in the mainline kernel. I also confirmed
that v4.14-rc6 fails to resume. Most likely Rafael's revert of
the following two commits fixed the issue:

5ba257249e9c ("Revert "PM / QoS: Fix default runtime_pm device resume latency"")
d5919dcc349d ("Revert "PM / QoS: Fix device resume latency PM QoS"")

Regards,

Tony
