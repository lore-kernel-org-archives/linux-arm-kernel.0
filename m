From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 16 Mar 2014 20:39:26 -0700
Subject: [PATCH v4 00/10] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
Message-ID: <20140317033926.GA20648@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 05:01:32PM +0530, Anup Patel wrote:
> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
> and Coordination Interface (PSCI) v0.1.
> 
> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
> such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
> provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
> CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
> later.

This doesn't seem to be true any longer does it?

> 
> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
> PSCI v0.2 to VCPUs.
> 

Besides the stuff you already added, I think you need to also add
returning ALREADY_ON for the CPU_ON call if the VCPU requested is
already on.

Thanks,
-Christoffer
