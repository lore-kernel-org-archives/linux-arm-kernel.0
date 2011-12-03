From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Dec 2011 09:30:12 +0000
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <000001ccb19d$2f9c5c60$8ed51520$%kim@samsung.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
 <000001ccb19d$2f9c5c60$8ed51520$%kim@samsung.com>
Message-ID: <20111203093012.GM9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2011 at 06:23:09PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Ack?
> > 
> > (If you're in the To: list I'm expecting a reply because this patch is
> > touching something you're responsible for.  Thanks.)
> > 
> > On Sun, Nov 06, 2011 at 05:33:35PM +0000, Russell King - ARM Linux wrote:
> > > We only need to set the system up for a soft-restart if we're going to
> > > be doing a soft-restart.  Provide a new function (soft_restart()) which
> > > does the setup and final call for this, and make platforms use it.
> > > Eliminate the call to setup_restart() from the default handler.
> > >
> > > This means that platforms arch_reset() function is no longer called with
> > > the page tables prepared for a soft-restart, and caches will still be
> > > enabled.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Sorry for late response...
> 
> For Samsung stuff:
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Too late, it's now part of devel-stable so I can't accept any more acks
for this.  Sorry.
