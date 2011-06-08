From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jun 2011 21:55:53 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID
	on rollover
In-Reply-To: <20110608204949.GA4713@e102144-lin.cambridge.arm.com>
References: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
	<20110608200106.GA13151@n2100.arm.linux.org.uk>
	<20110608202323.GA4430@e102144-lin.cambridge.arm.com>
	<20110608203615.GB13151@n2100.arm.linux.org.uk>
	<20110608204949.GA4713@e102144-lin.cambridge.arm.com>
Message-ID: <20110608205553.GD13151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 09:49:49PM +0100, Will Deacon wrote:
> Seems a shame given that disabling interrupts during switch_mm would fix
> this, but yes, reverting them is certainly better than having a broken
> kernel. I think you just need to revert 6944/1 and 6943/1; the other two
> from that series are fine to be left in.

Ok.

> > Let's take out these changes and sort it out properly - not only do we
> > need to sort out these problems but we should also get rid of the
> > __ARCH_WANT_INTERRUPTS_ON_CTXSW thing completely.  I have a patch which
> > I've only tested on SA-1110 which does this so far, but it needs a little
> > more work to clean up some stuff.
> 
> Could you post that code please? I can then rebase these patches against
> it for future inclusion in mainline.

I'd like to finish sorting it out properly first, so that it's all sane.

> Does the removal of
> __ARCH_WANT_INTERRUPTS_ON_CTXSW mean that switch_mm will run with interrupts
> disabled by default?

Yes, just like all but one other arch in the kernel.  The scheduler
folk would like to see this symbol die...
