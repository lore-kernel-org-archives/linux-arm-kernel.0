From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 11:10:26 -0700
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <20150316161449.GJ8656@n2100.arm.linux.org.uk>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
 <20150302112836.GA27317@amd> <20150316154409.GQ5264@atomide.com>
 <20150316161449.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <20150316181023.GT5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150316 09:15]:
> On Mon, Mar 16, 2015 at 08:44:10AM -0700, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [150302 03:32]:
> > > On Fri 2015-02-27 16:55:26, Pali Roh?r wrote:
> > > > This patch adds support for DT "/revision" and convert ATAG_REVISION to DT.
> > > > 
> > > > Pali Roh?r (2):
> > > >   arm: devtree: Set system_rev from DT revision
> > > >   arm: boot: convert ATAG_REVISION to DT revision field
> > > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Are these queued somewhere now? Sounds like this is the last pending
> > issue for n900 to use legacy user space with current mainline kernels,
> > so I'd like to get these in so we can get closer to making omap3 boot
> > in device tree only mode.
> 
> Not that I know of.  As everyone is aware, patches need to be in my
> patch system if they want me to apply them - which would've been
> especially important as I was away from kernel stuff for a week at
> the start of March (for medical reasons) and I can't be expected to
> track the status of stuff which is buried behind 1000+ extra mails.

Pali, care to upload these two patches to Russell's patch tracking
system if no other comments?
 
> In any case, I'm currently not accepting /any/ patches into my tree at
> present; I'm chasing a horrid instability on one of my test platforms
> which is making it impossible to tell whether any particular change or
> changes in my tree is responsible or not for it.  It doesn't seem to be
> a hardware failure (if it was, I'd simply take the board out of the
> nightly test system.)
> 
> It's quite literally taking hours to figure out what's going on - I've
> been on this for about 12 hours now and still not much closer to knowing
> what's causing it (other than I know that -rc1 plus my queue seems to be
> fine, -rc3 plus my queue is definitely broken, -rc3 alone is fine.  So
> something I'm already carrying seems to be responsible, but each time I
> identify a particular patch and drop _just_ that change, I find that the
> problem is back when I try my queue minus the bad changes.  With a test
> cycle time of 20+ minutes (due to the number of boots required to make
> certain of a dependable result), this is /really/ slow progress.
> 
> Right now, I can't be positively sure that /anything/ I have already
> merged isn't a factor in causing this problem, so I don't want to
> augment my tree with any additional patches which would upset my
> ability to move about in the tree, and get reproducable results from
> repeated testing.  To merge something else will probably mean I'll
> have to start again from the beginning and the last 12 hours spent
> testing will have been wasted.

Oh debugging those things sucks. Maybe try with CONFIG_DEBUG_SLAB to
see if you trigger any poison.

Regards,

Tony
