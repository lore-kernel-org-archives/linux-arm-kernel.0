From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 17:05:58 +0100
Subject: [PATCH][next] arm64: KVM: GICv3: move system register access to
 msr_s/mrs_s
In-Reply-To: <20140731133227.GA589@cbox>
References: <1406812599-18631-1-git-send-email-marc.zyngier@arm.com>
 <20140731131947.GT26853@arm.com> <20140731133227.GA589@cbox>
Message-ID: <20140731160558.GD26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 02:32:27PM +0100, Christoffer Dall wrote:
> On Thu, Jul 31, 2014 at 02:19:47PM +0100, Will Deacon wrote:
> > On Thu, Jul 31, 2014 at 02:16:39PM +0100, Marc Zyngier wrote:
> > > Commit 72c583951526 (arm64: gicv3: Allow GICv3 compilation with
> > > older binutils) changed the way we express the GICv3 system registers,
> > > but couldn't change the occurences used by KVM as the code wasn't
> > > merged yet.
> > > 
> > > Just fix the accessors.
> > > 
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > > -next is currently borked. I suggest we take this patch via the kvmarm tree,
> > > and only send our PR once the arm64 tree has hit Linus' tree. It contains
> > > the same dependency on the GIC tree anyway.
> > 
> > I'm fine with that as long as Paulo doesn't mind waiting for the arm64 stuff
> > to go in first (I have no reason to delay my pull request, so shouldn't be
> > an issue).
> > 
> > If it helps:
> > 
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > I can't help but point out that we wouldn't be in this mess if you'd got
> > your stuff into -next sooner ;)
> > 
> 
> Well yes, but it was hard to plan our holidays around the deadlines and
> unfortunately I couldn't find time to verify the kvmarm branch to make
> it ready for -next inclusion before I went on holiday this time.  In any
> case, this should be the exception rather than the rule, and I do try to
> get the next branch ready as soon as possible usually.

Understood, but the communication could have been a lot better.

Whilst you were away, -next broke due to the non-virt parts of the GICv3
driver (assumedly going via the irqchip tree?):

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275410.html

Catalin fixed that up, and then Jason stated that the intention was for
GICv3 to go via the arm64 tree (see above link). Based on that, we pulled
his tag into our tree and applied our fix on top.

Now a bunch of stuff has cropped up out of nowhere causing conflicts and
breakages for everybody ~3 days before the merge window opens (the code
defaults to 'y'). We're not mind-readers, so all it would have taken is
a mail to the relevant maintainers before everybody disappeared on holiday
saying (a) what the merge plan is and (b) what to do if everything goes
wrong while you're away.

Bah, maybe I'm just being grumpy...

Will
