From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 18 Sep 2018 02:55:05 +0100
Subject: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
In-Reply-To: <20180917104144.19188-19-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
Message-ID: <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which changes the virtual
>  memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>  flag KVM_VM_MIPS_VZ.
>
> +To configure the physical address space size for a VM (IPA size) on arm64,
> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of the
> +machine type has been reserved for specifying the PHYS_SHIFT.
> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
> +identified by checking KVM_CAP_ARM_VM_PHYS_SHIFT. For backward compatibility
> +a value of 0 selects 40bits.
> +

Given this as the API documentation, I don't think I could figure out
what I as a userspace user of it need to do without looking at the
kernel code. Could I ask you to expand it so that it is a bit less
terse and a bit more detailed? (For instance, what is a PHYS_SHIFT
and why do I have to specify it rather than just telling the kernel
I want a 48 bit guest address space?)

thanks
-- PMM
