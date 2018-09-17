From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 17 Sep 2018 15:20:15 +0100
Subject: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
In-Reply-To: <20180917104144.19188-19-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
Message-ID: <CAFEAcA-AKpkzSpMofMFxxf5XdYPii3PTB8xXDAvmyFWno7nZeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Allow specifying the physical address size limit for a new
> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
> allows us to finalise the stage2 page table as early as possible
> and hence perform the right checks on the memory slots
> without complication. The size is ecnoded as Log2(PA_Size) in
> bits[7:0] of the type field. For backward compatibility the
> value 0 is reserved and implies 40bits. Also, lift the limit
> of the IPA to host limit and allow lower IPA sizes (e.g, 32).
>
> The userspace could check the extension KVM_CAP_ARM_VM_PHYS_SHIFT
> for the availability of this feature. The cap check returns the
> maximum limit for the physical address shift supported by the host.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Peter Maydel <peter.maydell@linaro.org>

Typo: my surname has two "l"s in it.

thanks
-- PMM
