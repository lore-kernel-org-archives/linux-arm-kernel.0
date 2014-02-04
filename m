From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Feb 2014 11:38:23 -0800
Subject: [PATCH v3 0/4] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
References: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
Message-ID: <20140204193823.GM4167@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 03:18:12PM +0530, Anup Patel wrote:
> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
> and Coordination Interface (PSCI) v0.1.
> 
> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
> such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
> provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
> CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
> later.
> 
> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
> PSCI v0.2 to VCPUs.
> 
> Changlog:
> 
> V3:
>  - Make KVM_ARM_VCPU_PSCI_0_2 feature experiementatl for now so that
>    it fails for user space till all mandatory PSCI v0.2 functions are
>    emulated by KVM ARM/ARM64
>  - Have separate patch for making KVM_ARM_VCPU_PSCI_0_2 feature available
>    to user space. This patch can be defferred for now.
> 

I think we just want the feature bit when there's proper PSCI 0.2
support as per Mark's comments, so I'll hold off with reviewing until we
have a more complete patch set.

Thanks,
-Christoffer
