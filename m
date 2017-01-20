From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 20 Jan 2017 20:27:49 +0100
Subject: [PATCH v10 6/8] arm/arm64: vgic: Implement VGICv3 CPU interface
 access
In-Reply-To: <1480576187-5012-7-git-send-email-vijay.kilari@gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-7-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20170120192749.GG13531@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:39:45PM +0530, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> VGICv3 CPU interface registers are accessed using
> KVM_DEV_ARM_VGIC_CPU_SYSREGS ioctl. These registers are accessed
> as 64-bit. The cpu MPIDR value is passed along with register id.
> is used to identify the cpu for registers access.
> 
> The VM that supports SEIs expect it on destination machine to handle
> guest aborts and hence checked for ICC_CTLR_EL1.SEIS compatibility.
> Similarly, VM that supports Affinity Level 3 that is required for AArch64
> mode, is required to be supported on destination machine. Hence checked
> for ICC_CTLR_EL1.A3V compatibility.
> 
> The arch/arm64/kvm/vgic-sys-reg-v3.c handles read and write of VGIC
> CPU registers for AArch64.
> 
> For AArch32 mode, arch/arm/kvm/vgic-v3-coproc.c file is created but
> APIs are not implemented.
> 
> Updated arch/arm/include/uapi/asm/kvm.h with new definitions
> required to compile for AArch32.
> 
> The version of VGIC v3 specification is define here
> Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---

With Eric's comments addressed on this patch, it now looks good to me.

-Christoffer
