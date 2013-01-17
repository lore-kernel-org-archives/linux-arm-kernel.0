From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Jan 2013 17:37:35 +0000
Subject: [kvmarm] [PATCH v6 02/13] KVM: ARM: Introduce
 KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <20130116180028.29393.62418.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
 <20130116180028.29393.62418.stgit@ubuntu>
Message-ID: <CAFEAcA9rQABRT7ybfn_BSsykMO+OhoPt6y7RhNkdXyUSr4fhtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2013 18:00, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl

Patch subject needs updating with new name of this ioctl
(KVM_ARM_SET_DEVICE_ADDR)...

> On ARM (and possibly other architectures) some bits are specific to the
> model being emulated for the guest and user space needs a way to tell
> the kernel about those bits.  An example is mmio device base addresses,
> where KVM must know the base address for a given device to properly
> emulate mmio accesses within a certain address range or directly map a
> device with virtualiation extensions into the guest address space.

"virtualization", while I'm here.

> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -65,6 +65,19 @@ struct kvm_regs {
>  #define KVM_ARM_TARGET_CORTEX_A15      0
>  #define KVM_ARM_NUM_TARGETS            1
>
> +/* KVM_SET_DEVICE_ADDRESS ioctl id encoding */
> +#define KVM_DEVICE_TYPE_SHIFT          0
> +#define KVM_DEVICE_TYPE_MASK           (0xffff << KVM_DEVICE_TYPE_SHIFT)
> +#define KVM_DEVICE_ID_SHIFT            16
> +#define KVM_DEVICE_ID_MASK             (0xffff << KVM_DEVICE_ID_SHIFT)

...and this comment and I guess these constant names presumably
should have "ARM" in them?

> +/* Available with KVM_CAP_SET_DEVICE_ADDR */

KVM_CAP_ARM_SET_DEVICE_ADDR.

-- PMM
