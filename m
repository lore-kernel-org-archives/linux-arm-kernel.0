From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 16 Aug 2016 19:37:47 +0200
Subject: [RFC PATCH v2 0/4] arm/arm64: vgic-new: Implement API for vGICv3
 live migration
In-Reply-To: <1470740326-27751-1-git-send-email-vijay.kilari@gmail.com>
References: <1470740326-27751-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20160816173747.GH14088@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On Tue, Aug 09, 2016 at 04:28:42PM +0530, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> This patchset adds API for saving and restoring
> of VGICv3 registers to support live migration with new vgic feature.
> This API definition is as per version of VGICv3 specification
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
> 
> To test live migration with QEMU, use below patch series
> https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg01444.html
> 
> The patch 3 & 4 are picked from the Pavel's previous implementation.
> http://www.spinics.net/lists/kvm/msg122040.html
> 
> v1 => v2:
>  - The init sequence change patch is no more required.
>    Fixed in patch 2 by using static vgic_io_dev regions structure instead
>    of using dynamic allocation pointer.
>  - Updated commit message of patch 4.
>  - Dropped usage of union to manage 32-bit and 64-bit access in patch 1.
>    Used local variable for 32-bit access.
>  - Updated macro __ARM64_SYS_REG and ARM64_SYS_REG in 
>    arch/arm64/include/uapi/asm/kvm.h as per qemu requirements.
> 
I think you should have enough to go on by now for a new revision.  You
can include the two patches I just sent with the series '[PATCH v2]
Rework vgic_attr_regs_access' in the beginning of your series and then
base your work on that, assuming nobody else screams about this.

If you use that approach, and you address the missing soft pending state
etc. that Peter pointed out, then we should be ready for a detailed
review.

Looking forward to the next version.

Thanks,
-Christoffer
