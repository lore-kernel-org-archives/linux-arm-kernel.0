From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Apr 2013 10:08:26 +0100
Subject: [PATCH v4 3/7] ARM: KVM: move to a KVM provided HYP idmap
In-Reply-To: <CAEDV+gK=4VwBQUNkAWSmo3j1A2GwewXctNno3NBpyOFG0C8YFw@mail.gmail.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
 <1365790327-2138-4-git-send-email-marc.zyngier@arm.com>
 <CAEDV+gK=4VwBQUNkAWSmo3j1A2GwewXctNno3NBpyOFG0C8YFw@mail.gmail.com>
Message-ID: <20130418090826.GB28942@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 08:37:00PM +0100, Christoffer Dall wrote:
> On Fri, Apr 12, 2013 at 11:12 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > After the HYP page table rework, it is pretty easy to let the KVM
> > code provide its own idmap, rather than expecting the kernel to
> > provide it. It takes actually less code to do so.
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/idmap.h   |  1 -
> >  arch/arm/include/asm/kvm_mmu.h |  1 -
> >  arch/arm/kvm/mmu.c             | 24 +++++++++++++++++++++++-
> >  arch/arm/mm/idmap.c            | 32 +-------------------------------
> >  4 files changed, 24 insertions(+), 34 deletions(-)

[...]

> Russell,
> 
> I would appreciate your ack on this one so we can merge this through
> the KVM tree, or alternatively let us know if this needs to go your
> tree, so we can plan accordingly for the next merge window.

The core ARM part of this is basically just deleting code that KVM doesn't
require any more. I'm not aware of any other patches in this area at the
moment so, unless Russell objects, I don't think there would be a problem
with this going via the kvm tree providing that it sits in -next until it's
in mainline.

Will
