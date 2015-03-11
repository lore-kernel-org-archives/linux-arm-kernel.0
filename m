From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Mar 2015 12:58:42 +0000
Subject: [PATCH v2 0/5] GICv3: add 32bit compatibility
In-Reply-To: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <20150311125842.GF21998@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Philippe,

On Mon, Mar 02, 2015 at 06:20:27PM +0000, Jean-Philippe Brucker wrote:
> This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
> PPIs and SPIs support is present, no ITS.
> 
> It is now based on Linux 4.0-rc1, which contains Andre's GICv3 emulation
> series for KVM [1]. With this support along with the kvmtool patches
> mentioned in [1], it is possible to run ARM guests that use GICv3.
> 
> Changes since v1 [2]:
> * rebased on 4.0-rc1
> * fix the mistakes pointed out by Russell and Vladimir
> * add a patch to select ARM_GIC_V3 under ARCH_VIRT, as suggested by Marc
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/316230.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310124.htm
> 
> Cheers,
> Jean
> 
> 
> Jean-Philippe Brucker (5):
>   arm64: GICv3: refactor the AArch64 specific parts
>   arm64: GICv3: change unsigned types for AArch32 compatibility
>   arm64: GICv3: Specialize readq and writeq accesses
>   ARM: add 32bit support to GICv3
>   ARM: virt: select ARM_GIC_V3
> 
>  arch/arm/Kconfig                    |   1 +
>  arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
>  include/linux/irqchip/arm-gic-v3.h  | 115 ++++++-----------------

Please include the irqchip maintainers (myself and Thomas) on future revisions
of this series.

thx,

Jason.
