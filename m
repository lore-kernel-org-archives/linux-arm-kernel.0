From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Feb 2012 10:06:34 -0800
Subject: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
In-Reply-To: <20120209175937.GC19159@n2100.arm.linux.org.uk>
References: <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk>
 <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk>
 <87ipjgx3g3.fsf@ti.com> <20120209004027.GF16877@atomide.com>
 <20120209164913.GB19159@n2100.arm.linux.org.uk>
 <20120209171830.GH16877@atomide.com>
 <20120209172747.GG1426@atomide.com>
 <20120209175937.GC19159@n2100.arm.linux.org.uk>
Message-ID: <20120209180634.GI1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120209 09:28]:
> On Thu, Feb 09, 2012 at 09:27:47AM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120209 08:47]:
> > > 
> > > So that leaves me only the second one to queue that adds checks
> > > for the PMIC info for boards that don't have it, see below.
> > ...
> >  
> > > From d269914ece0498f31603ecd85ed3d7a586b3cbcd Mon Sep 17 00:00:00 2001
> > > From: Kevin Hilman <khilman@ti.com>
> > > Date: Fri, 30 Sep 2011 11:24:04 -0700
> > > Subject: [PATCH] ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
> > > 
> > > Current code registers voltage layer details for TWL PMIC even when a TWL
> > > has not been registered.  Fix this to only register the TWL with voltage
> > > layer when the TWL PMIC is initialized by board-level code.
> > > 
> > > Tested-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
> > > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > 
> > Never mind. This one is already in mainline as commit
> > 46232a3622c6e33605906ee6690dfef372925f53.
> 
> Okay, I'll re-send patches 1 and 5 for acks then.  Once I have those,
> can I assume that everyone is happy for patches 1 to 15 to go upstream?

Yes as long as Kevin is happy with them.

After you repost those two patches, I'll update linux-omap with
your fixes + tty fixes + my fixes for people to test with.

Regards,

Tony
