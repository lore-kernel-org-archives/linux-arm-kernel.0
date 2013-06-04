From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Jun 2013 14:41:11 +0100
Subject: Planning the merge of KVM/arm64
In-Reply-To: <CAAhSdy1c-h3sh-x2_fu2aqhcijaz7FJ5-cZnEy9k2OeMAkxwrA@mail.gmail.com>
References: <51ADDDAE.4040705@arm.com>
 <CAAhSdy1c-h3sh-x2_fu2aqhcijaz7FJ5-cZnEy9k2OeMAkxwrA@mail.gmail.com>
Message-ID: <20130604134110.GA25090@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:13:52PM +0100, Anup Patel wrote:
> Hi Marc,
> 
> On Tue, Jun 4, 2013 at 5:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > Guys,
> >
> > The KVM/arm64 code is now, as it seems, in good enough shape to be
> > merged. I've so far addressed all the comments, and it doesn't seem any
> > worse then what is queued for its 32bit counterpart.
> >
> > For reference, it is sitting there:
> > git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> > kvm-arm64/kvm
> >
> > What is not defined yet is the merge path:
> > - It is touching some of the arm64 core code, so it would be better if
> > it was merged through the arm64 tree
> > - It is depending on some of the patches in the core KVM queue (the
> > vgic/timer move to virt/kvm/arm/)
> > - It is also depending on some of the patches that are in the KVM/ARM
> > queue (parametrized timer interrupt, some MMU/MMIO fixes)
> >
> > So I can see two possibilities:
> > - Either I can rely on a stable branch from both KVM and KVM/ARM trees
> > on which I can base my tree for Catalin/Will to pull,
> > - Or I ask Catalin to only pull the arm64 part *minus the Kconfig*, and
> > only merge this last bit when the dependencies are satisfied in Linus' tree.
> >
> > What do you guys think?
> 
> I had quick look at your kvm-arm64/kvm branch. I agree with the approach
> of going through arm64 tree.
> 
> FYI, latest tested branch on APM ARMv8 board is kvm-arm64/kvm-3.10-rc3
> branch.
> 
> From my side, +1 for the second option that is "pull the arm64 part *minus
> the Kconfig*, and ..."

+1 as well for the second option.

-- 
Catalin
