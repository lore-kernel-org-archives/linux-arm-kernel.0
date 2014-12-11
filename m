From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Dec 2014 17:38:37 +0000
Subject: [PATCH 0/4] GICv3: add 32bit compatibility
In-Reply-To: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <5489D69D.7070900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/14 14:23, Jean-Philippe Brucker wrote:

Hi Jean-Philippe,

> This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
> PPIs and SPIs support is present. No ITS nor virtualisation.
> 
> It is based on 3.18.
> 
> Jean-Philippe Brucker (4):
>   arm64: GICv3: refactor the AArch64 specific parts
>   arm64: GICv3: change unsigned types for AArch32 compatibility
>   arm64: GICv3: Specialize readq and writeq accesses
>   ARM: add 32bit support to GICv3
> 
>  arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
>  include/linux/irqchip/arm-gic-v3.h  |  95 +++----------------
>  4 files changed, 356 insertions(+), 131 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch_gicv3.h
>  create mode 100644 arch/arm64/include/asm/arch_gicv3.h
> 

Overall, this looks good to me (once you've sorted the nits spotted by
Russell). It is going to conflict quite badly with what is going to be
merged in 3.19 though. Any chance you could rebase it on top of -rc1
once it is out?

Also, I don't see an obvious way to select CONFIG_ARM_GIC_V3 for ARM
(arm64 selects it automatically). What about selecting it from
ARCH_VIRT, which is likely to be the primary user of this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
