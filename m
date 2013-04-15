From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 14 Apr 2013 23:46:50 -0700
Subject: [PATCH] ARM: KVM: fix unbalanced get_cpu() in access_dcsw
In-Reply-To: <4a199cdd4998480ed6ba3f1858698903@localhost>
References: <1365786828-548-1-git-send-email-marc.zyngier@arm.com>
 <20130412181332.GB5075@mudshark.cambridge.arm.com>
 <4a199cdd4998480ed6ba3f1858698903@localhost>
Message-ID: <20130415064650.GA44752@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 09:17:46PM +0200, Marc Zyngier wrote:
> On Fri, 12 Apr 2013 19:13:32 +0100, Will Deacon <will.deacon@arm.com>
> wrote:
> > On Fri, Apr 12, 2013 at 06:13:48PM +0100, Marc Zyngier wrote:
> >> In the very unlikely event where a guest would be foolish enough to
> >> *read* from a write-only cache maintainance register, we end up
> >> with preemption disabled, due to a misplaced get_cpu().
> >> 
> >> Just move the "is_write" test outside of the critical section.
> >> 
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > I found it second time around!
> > 
> >   Reported-by: Will Deacon <will.deacon@arm.com>
> 
> Indeed you did! :-)
> 
> I'll add that to the commit, and on a couple of other as well...

I applied the patch and added the tag, thanks.

-Christoffer
