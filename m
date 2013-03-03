From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Mar 2013 11:47:43 +0000
Subject: Fixing KVM/ARM breakage in mainline
In-Reply-To: <20130225122117.GE12299@redhat.com>
References: <512B5693.4000608@arm.com> <20130225122117.GE12299@redhat.com>
Message-ID: <20130303114743.GH17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 02:21:17PM +0200, Gleb Natapov wrote:
> On Mon, Feb 25, 2013 at 12:18:27PM +0000, Marc Zyngier wrote:
> > Russell, Marcelo, Gleb,
> > 
> > Commit 89f8833 (Merge tag 'kvm-3.9-1' of
> > git://git.kernel.org/pub/scm/virt/kvm/kvm) broke KVM/ARM. Nothing
> > fundamental, just annoying enough.
> > 
> > I've posted patches against next-20130215 some time ago:
> > http://comments.gmane.org/gmane.comp.emulators.kvm.devel/105019
> > 
> > I've now created a branch based off mainline as of this morning, and
> > containing these fixes:
> > git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> > kvm-arm/core-3.9-rc1-fixes
> > 
> > Now the question is: who wants to merge this? The diffstat looks like this:
> > 
> I was going to merge it today.

I notice that my randconfig build last night tripped over the:

include/linux/kvm_host.h:333:34: error: 'KVM_USER_MEM_SLOTS' undeclared here (not in a function)

error which Marc's patches fix.
