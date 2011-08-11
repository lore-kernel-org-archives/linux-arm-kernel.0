From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 11 Aug 2011 19:52:32 +0200
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300:
	patch physoffset by default)
In-Reply-To: <20110811082413.GA4775@n2100.arm.linux.org.uk>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
	<20110810091635.GF1831@n2100.arm.linux.org.uk>
	<20110810092206.GE10121@e102144-lin.cambridge.arm.com>
	<20110810092955.GG1831@n2100.arm.linux.org.uk>
	<20110811082413.GA4775@n2100.arm.linux.org.uk>
Message-ID: <20110811175232.GA1916@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:24 Thu 11 Aug     , Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 10:29:55AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Aug 10, 2011 at 10:22:06AM +0100, Will Deacon wrote:
> > > On Wed, Aug 10, 2011 at 10:16:35AM +0100, Russell King - ARM Linux wrote:
> > > > On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:
> > > > > From: Linus Walleij <linus.walleij@linaro.org>
> > > > > 
> > > > > This works like a charm so I'll just default-select it.
> > > > 
> > > > Well, we can remove the EXPERIMENTAL status of this option now.  This
> > > > raises the question is whether we should now default it to 'y' - I
> > > > think we should.  Anyone have any objections?
> > > 
> > > I've been running with this option enabled for the collection of ARM boards
> > > I have and the only problem I have encountered was related to u-boot loading
> > > at the wrong address.
> > > 
> > > So I'm all for enabling it by default, especially since it will force out
> > > any remaining issues for boards where this hasn't been used extensively.
> > 
> > Maybe also making the option hidden depending on EXPERT, or even EMBEDDED
> > would be a good idea too.  I think it falls into at least the same class
> > as UID16, sysctl, hotplug, printk, etc. which are all EXPERT options.
> 
> Right, I'm now committing a patch to hide the option unless EMBEDDED
> is enabled.  I think this means we should get rid of the 'select
> ARM_PATCH_PHYS_VIRT' statements from the various platforms, so that
> folk can optimize away that code if they know what they're doing.
> 
> Note: this patch will conflict with the removal of the 16-bit P2V
> patching, so we need to sort that out.
> 
> 8<---------
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> ARM: enable ARM_PATCH_PHYS_VIRT by default
> 
> Enable virtual to physical translation patching by default in all
> kernels.  Hide the option behind EMBEDDED.
> 
> This can still be turned off if people desire, and they know what
> they're doing, to shrink the size of the kernel to a minimum.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
