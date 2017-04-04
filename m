From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Apr 2017 18:11:33 +0100
Subject: [PATCH 00/15] arm64/kvm: use common sysreg definitions
In-Reply-To: <20170329084146.GA15778@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
 <87a88tv94d.fsf@on-the-bus.cambridge.arm.com>
 <20170310183555.GB6271@arm.com>
 <20170322183512.GB27921@leverpostej>
 <20170328184828.GF8643@leverpostej> <20170328202931.GF20211@cbox>
 <20170329084146.GA15778@arm.com>
Message-ID: <20170404171133.GG19969@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 09:41:47AM +0100, Will Deacon wrote:
> On Tue, Mar 28, 2017 at 10:29:31PM +0200, Christoffer Dall wrote:
> > On Tue, Mar 28, 2017 at 07:48:28PM +0100, Mark Rutland wrote:
> > > On Wed, Mar 22, 2017 at 06:35:13PM +0000, Mark Rutland wrote:
> > > > On Fri, Mar 10, 2017 at 06:35:55PM +0000, Will Deacon wrote:
> > > > > On Fri, Mar 10, 2017 at 08:17:22AM +0000, Marc Zyngier wrote:
> > > > 
> > > > > > The next question is how do we merge this. Obviously, we can't split it
> > > > > > between trees, and this is very likely to clash with anything that we
> > > > > > will merge on the KVM side (the sysreg table is a popular place).
> > > > > > 
> > > > > > Will, Catalin: Would it make sense to create a stable branch with these
> > > > > > patches, and merge it into both the arm64 and KVM trees? That'd make
> > > > > > things easier...
> > > > > 
> > > > > I think the scope for conflict on our side is pretty high too, so a shared
> > > > > branch might be the best way to go. I don't want to branch just yet though,
> > > > > so I'll probably wait a week or so before setting something in stone.
> > > > 
> > > > Any further thoughts on this?
> > > > 
> > > > Christoffer has Acked the KVM bits, so if you're happy to do so for the
> > > > arm64 bits I can make a stable branch.
> > > 
> > > Looking around, it doesn't look like there's anything outside of arm64
> > > that'll conflict on the <asm/sysreg.h> changes, and git's happy to merge
> > > my changes with Suzuki's changes currently queued in arm64's
> > > for-next/core branch.
> > > 
> > > I think it would make sense for those to be in a common branch taken by
> > > both the arm64 and KVM trees, with the KVM-specific parts being taken by
> > > KVM alone atop of that.
> > > 
> > > Would everyone be happy with that?
> > 
> > I'm happy with that.
> > 
> > > 
> > > For reference, I've updated my branches so that arm64/common-sysreg only
> > > contains the common parts, with the KVM parts atop of that in
> > > kvm/common-sysreg.
> > > 
> > 
> > Will, Catalin:  Let me know if you're going to pull from common-sysreg
> > and I'll do the same and add the kvm patches above.
> 
> I think that's what we'll do, but Catalin's out this week (we're taking it
> in turns to go to work). I'd say go ahead and pull it into kvm if there
> aren't any conflicts. No need to wait for us.

I pulled it into the arm64 for-next/core as well (to be pushed out later
today).

-- 
Catalin
