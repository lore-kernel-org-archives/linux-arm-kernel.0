From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 12 Oct 2013 18:11:16 -0700
Subject: [PATCH v3 0/2] KVM/ARM Huge pages support
In-Reply-To: <52543F61.9050507@arm.com>
References: <1380903201-32644-1-git-send-email-christoffer.dall@linaro.org>
 <52543F61.9050507@arm.com>
Message-ID: <20131013011116.GB8200@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:22:41PM +0100, Marc Zyngier wrote:
> On 04/10/13 17:13, Christoffer Dall wrote:
> > This small series adds support for Transparent Huge Pages and hugetlbfs
> > pages for KVM on the arm and arm64 architectures.
> > 
> > Measurements have shown that using huge pages in for stage-2 mappings
> > provides up to more than 15% performance increase for some workloads.
> > 
> > The patch series applies to kvm/next, but depends on the patch sent
> > earlier:
> > http://marc.info/?l=kvm&m=138074894126934&w=2
> > 
> > The whole thing can also be cloned from here:
> > git://git.linaro.org/people/cdall/linux-kvm-arm.git kvm-arm-hugepages-v3
> > 
> > See the patches for changelogs.
> > 
> > Christoffer Dall (2):
> >   KVM: ARM: Support hugetlbfs backed huge pages
> >   KVM: ARM: Transparent huge page (THP) support
> > 
> >  arch/arm/include/asm/kvm_mmu.h         |  17 ++-
> >  arch/arm/include/asm/pgtable-3level.h  |   2 +
> >  arch/arm/kvm/mmu.c                     | 223 +++++++++++++++++++++++++++------
> >  arch/arm64/include/asm/kvm_mmu.h       |  12 +-
> >  arch/arm64/include/asm/pgtable-hwdef.h |   2 +
> >  5 files changed, 212 insertions(+), 44 deletions(-)
> 
> Looks good to me. For the series:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Thanks, waiting for the kvm huge page defines patch series to be applied
to kvm/next before I apply this.

-Christoffer
