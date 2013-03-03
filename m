From: gleb@redhat.com (Gleb Natapov)
Date: Sun, 3 Mar 2013 13:53:18 +0200
Subject: Fixing KVM/ARM breakage in mainline
In-Reply-To: <20130303114743.GH17833@n2100.arm.linux.org.uk>
References: <512B5693.4000608@arm.com> <20130225122117.GE12299@redhat.com>
 <20130303114743.GH17833@n2100.arm.linux.org.uk>
Message-ID: <20130303115318.GA18298@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 03, 2013 at 11:47:43AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 25, 2013 at 02:21:17PM +0200, Gleb Natapov wrote:
> > On Mon, Feb 25, 2013 at 12:18:27PM +0000, Marc Zyngier wrote:
> > > Russell, Marcelo, Gleb,
> > > 
> > > Commit 89f8833 (Merge tag 'kvm-3.9-1' of
> > > git://git.kernel.org/pub/scm/virt/kvm/kvm) broke KVM/ARM. Nothing
> > > fundamental, just annoying enough.
> > > 
> > > I've posted patches against next-20130215 some time ago:
> > > http://comments.gmane.org/gmane.comp.emulators.kvm.devel/105019
> > > 
> > > I've now created a branch based off mainline as of this morning, and
> > > containing these fixes:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> > > kvm-arm/core-3.9-rc1-fixes
> > > 
> > > Now the question is: who wants to merge this? The diffstat looks like this:
> > > 
> > I was going to merge it today.
> 
> I notice that my randconfig build last night tripped over the:
> 
> include/linux/kvm_host.h:333:34: error: 'KVM_USER_MEM_SLOTS' undeclared here (not in a function)
> 
> error which Marc's patches fix.
The patches that were send to the kvm mailing list are in Linus tree for
quite a while now:

3b8cd8a015f3db85624c0fdb591956aed7f61b65 ARM: KVM: fix compilation after removal of user_alloc from struct kvm_memory
2b5e1e474fd7b0f2540a052d15465ba953dd30b1 ARM: KVM: Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
bef103aa7dd75121f66848d91f6b6179d40c1a71 ARM: KVM: fix kvm_arch_{prepare,commit}_memory_region

Are there additional patches that I missed?

--
			Gleb.
