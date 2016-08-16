From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Aug 2016 14:14:47 +0000
Subject: [PATCH 0/4] arm64: marvell: add support for the PIC and PMU
In-Reply-To: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160816141447.GQ3353@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Aug 05, 2016 at 04:55:17PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This small patch series intends to add support for the PMU of the
> Cortex-A72 cores found in the Marvell Armada 7K/8K SoCs.
> 
> However, the interrupt of the PMU is not directly connected to the
> GIC, but goes through a secondary interrupt controller called the
> PIC. Therefore, this series starts by adding a small driver for this
> interrupt controller, before enabling the PIC and the PMU in the
> Device Tree.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   dt-bindings: interrupt-controller: add DT binding for Marvell 7K/8K
>     PIC
>   irqchip: irq-mvebu-pic: new driver for Marvell Armada 7K/8K PIC
>   arm64: marvell: enable the Marvell PIC driver
>   arm64: dts: marvell: describe the PIC and PMU on Armada 7K/8K
> 
>  .../interrupt-controller/marvell,armada-8k-pic.txt |  25 +++
>  arch/arm64/Kconfig.platforms                       |   1 +
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  14 ++
>  drivers/irqchip/Kconfig                            |   3 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mvebu-pic.c                    | 195 +++++++++++++++++++++
>  6 files changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt
>  create mode 100644 drivers/irqchip/irq-mvebu-pic.c

Patches 1-3 applied to irqchip/mvebu64.  Patch 1 has Rob's Ack.  I
assume you'll route the dtsi change through a separate branch.

thx,

Jason.
