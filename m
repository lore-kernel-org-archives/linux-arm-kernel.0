From: mtosatti@redhat.com (Marcelo Tosatti)
Date: Wed, 25 Mar 2015 18:41:12 -0300
Subject: [PATCH v2 02/12] KVM: move iodev.h from virt/kvm/ to include/kvm
In-Reply-To: <5512E992.1020800@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-3-git-send-email-andre.przywara@arm.com>
 <5512E992.1020800@arm.com>
Message-ID: <20150325214112.GC3649@amt.cnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:00:02PM +0000, Marc Zyngier wrote:
> On 23/03/15 15:58, Andre Przywara wrote:
> > iodev.h contains definitions for the kvm_io_bus framework. This is
> > needed both by the generic KVM code in virt/kvm as well as by
> > architecture specific code under arch/. Putting the header file in
> > virt/kvm and using local includes in the architecture part seems at
> > least dodgy to me, so let's move the file into include/kvm, so that a
> > more natural "#include <kvm/iodev.h>" can be used by all of the code.
> > This also solves a problem later when using struct kvm_io_device
> > in arm_vgic.h.
> > Fixing up the FSF address in the GPL header and a wrong include path
> > on the way.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Paolo, Marcelo: can we have your Ack on this?
> 
> Thanks,

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
