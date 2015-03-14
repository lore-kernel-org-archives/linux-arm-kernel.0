From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 15:43:29 +0100
Subject: [PATCH 02/12] KVM: move iodev.h from virt/kvm/ to include/kvm
In-Reply-To: <1426263012-22935-3-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314144329.GH10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:02PM +0000, Andre Przywara wrote:
> iodev.h contains definitions for the kvm_io_bus framework. This is
> needed both by the generic KVM code in virt/kvm as well as by
> architecture specific code under arch/. Putting the header file in
> virt/kvm and using local includes in the architecture part seems at
> least dodgy to me, so let's move the file into include/kvm, so that a
> more natural "#include <kvm/iodev.h>" can be used by all of the code.
> This also solves a problem later when using struct kvm_io_device
> in arm_vgic.h.
> Fixing up the FSF address in the GPL header and a wrong include path
> on the way.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
