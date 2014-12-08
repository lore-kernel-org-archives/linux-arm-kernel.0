From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Dec 2014 15:18:07 +0100
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <20141208061746.GD16827@intel.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com>
Message-ID: <20141208141807.GC8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 11:47:46AM +0530, Vinod Koul wrote:
> On Mon, Nov 17, 2014 at 02:41:54PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > As we discussed a couple of weeks ago, this is the third attempt at
> > creating a generic behaviour for slave capabilities retrieval so that
> > generic layers using dmaengine can actually rely on that.
> > 
> > That has been done mostly through two steps: by moving out the
> > sub-commands of the device_control callback, so that the dmaengine
> > core can then infer from that wether a sub-command is implemented, and
> > then by moving the slave properties, such as the supported buswidth,
> > to the structure dma_device itself.
> 
> Okay managed to get this done. Apart from the two issues identified didn't
> find anything so applied and pushed to a branch
> "topic/slave_caps_device_control_fix"
> 
> Today did some compile tests and found few warnings, were trivial but I
> am worried about the testing of this code. Has anyone tested this, if so
> which platforms are covered Since I pushed base branch last night, Feng's
> bot covered it and all was OK. Looks like Feng's bot doesn't have wide
> coverage of arm platforms, wasn't there one run by arm guys which tries to
> test and boot, if so can we get this tested there please.
> 
> So bit sceptical for merging now. I will send the patches which I have
> applied on top of this

Which is why I wanted to merge this at the *beginning* of the
development cycle in the first place....

These patches have been sent more than 2 weeks ago, and were exactly
the same as the ones send at the end of October, rebased and updated
to take into account the drivers that were merged in between.

In short, these patches have been hanging around since 6 weeks. I
relied probably too much on the intel's build bot. This is not a
mistake I'll repeat. But blaming it on me because they came too late
is *very* unfair.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/e9e02940/attachment.sig>
