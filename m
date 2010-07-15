From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 21:06:18 +0100
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <20100715130214.4c9303b2.akpm@linux-foundation.org>
References: <4C3C72C6.4000005@canonical.com>
	<20100715130214.4c9303b2.akpm@linux-foundation.org>
Message-ID: <20100715200618.GA6773@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 01:02:14PM -0700, Andrew Morton wrote:
> > BugLink: http://bugs.launchpad.net/bugs/601226
> > 
> > When CUPS loads, it tries to load several drivers that it may need.
> > When one of these drivers, specifically parport_pc is loaded on ARM
> > based systems, it causes a segmentation fault as the ISA addresses
> > which are attempted are not writable on non-PC based architectures.
> > This code prevents ISA addresses from being attempted except on x86.
> > 
> 
> That sounds like a pretty serious problem.  But presumably it isn't -
> otherwise it would have been fixed earlier!
> 
> So what actions are required to trigger this bug and why aren't others
> seeing it?

Note that we have machines which have ISA parallel ports, so it's not
this simple.

Why not just avoid selecting and building parport_pc on these machines?

I mean, the Beagleboard doesn't have PCI nor ISA, so why is parport_pc
being built for production use?
