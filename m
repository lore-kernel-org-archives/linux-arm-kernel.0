From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 20 Feb 2016 10:40:19 +0000
Subject: [PATCH v3 0/7] irqchip: introduce the Alpine MSIX driver
In-Reply-To: <1455895369-13187-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1455895369-13187-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20160220104019.21e425c6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016 16:22:42 +0100
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

Hi Antoine,

> Hi all,
> 
> This series introduce the Alpine MSIX driver, and enables it in both
> the Alpine v1 and Alpine v2 device trees.
> 
> This series depends on "[PATCH v2 0/3] arm64: introduce the Alpine support":
> https://lkml.org/lkml/2016/2/10/83
> 
> You can find the series at:
> https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix
> 
> Antoine
> 
> Since v2:
>   - Updated the documentation (added a reference to the GIC documentation).
> 
> Since v1:
>   - Added an interrupt-parent property in the documentation example.
>   - Updated to use bitmap_*() instead of *_bit().
>   - Removed the static irq_set_affinity to use irq_chip_set_affinity_parent().
>   - Updated the address field to use phys_addr_t.
>   - Added a comment on why we're setting bit 16 in the address.
>   - Patched the gic_set_affinity() function in irqchip/gic-v3.
> 
> Antoine Tenart (7):
>   irqchip/gic-v3: always return IRQ_SET_MASK_OK_DONE in gic_set_affinity
>   irqchip: add the Alpine MSIX interrupt controller
>   Documentation: bindings: document the Alpine MSIX driver
>   arm64: dts: alpine: add the MSIX node in the Alpine v2 dtsi
>   ARM: dts: alpine: add the MSIX node
>   arm64: alpine: select the Alpine MSI controller driver
>   arm: alpine: select the Alpine MSI controller driver
> 
>  .../interrupt-controller/al,alpine-msix.txt        |  26 ++
>  arch/arm/boot/dts/alpine.dtsi                      |  10 +
>  arch/arm/mach-alpine/Kconfig                       |   1 +
>  arch/arm64/Kconfig.platforms                       |   1 +
>  arch/arm64/boot/dts/al/alpine-v2.dtsi              |  10 +
>  drivers/irqchip/Kconfig                            |   6 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-alpine-msi.c                   | 293 +++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c                       |   2 +-
>  9 files changed, 349 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
>  create mode 100644 drivers/irqchip/irq-alpine-msi.c
> 

I've queued the first three patches in my irq/gic-4.6 branch. I'd
expect the last 4 patches to be taken care off by armsoc once the code
has made it into Linus' tree.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
