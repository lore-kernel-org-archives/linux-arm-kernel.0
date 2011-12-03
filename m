From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 03 Dec 2011 18:45:39 +0900
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <20111203093012.GM9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
 <000001ccb19d$2f9c5c60$8ed51520$%kim@samsung.com>
 <20111203093012.GM9581@n2100.arm.linux.org.uk>
Message-ID: <000401ccb1a0$50acfe20$f206fa60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Sat, Dec 03, 2011 at 06:23:09PM +0900, Kukjin Kim wrote:
> > Russell King - ARM Linux wrote:
> > >
> > > Ack?
> > >
> > > (If you're in the To: list I'm expecting a reply because this patch is
> > > touching something you're responsible for.  Thanks.)
> > >
> > > On Sun, Nov 06, 2011 at 05:33:35PM +0000, Russell King - ARM Linux
> wrote:
> > > > We only need to set the system up for a soft-restart if we're going
> to
> > > > be doing a soft-restart.  Provide a new function (soft_restart())
> which
> > > > does the setup and final call for this, and make platforms use it.
> > > > Eliminate the call to setup_restart() from the default handler.
> > > >
> > > > This means that platforms arch_reset() function is no longer called
> with
> > > > the page tables prepared for a soft-restart, and caches will still
> be
> > > > enabled.
> > > >
> > > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > Sorry for late response...
> >
> > For Samsung stuff:
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Too late, it's now part of devel-stable so I can't accept any more acks
> for this.  Sorry.

OK, I see.

But I did send my ack in the beginning of Nov on cover [0/7] like
following...
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/071800.h
tml

So I didn't send my ack on this...

As a note, I'm sorting out header files, local headers in Samsung stuff as
per your suggestion and you can see them in the next week.

Anyway, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
