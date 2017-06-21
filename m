From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Jun 2017 16:47:20 +0100
Subject: [PATCH v5 0/6] Add support for the ICU unit in Marvell Armada
 7K/8K
In-Reply-To: <87r2yd1h5x.fsf@free-electrons.com>
References: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
 <e87dc80c-f85c-1b20-c2e8-cd03922dacd9@arm.com>
 <20170621171809.34bcce1e@windsurf.home> <87r2yd1h5x.fsf@free-electrons.com>
Message-ID: <245df82c-60b1-bc4b-e343-5435713c453c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/17 16:42, Gregory CLEMENT wrote:
> Hi Marc and Thomas,
>  
>  On mer., juin 21 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> 
>> Hello,
>>
>> On Wed, 21 Jun 2017 16:14:21 +0100, Marc Zyngier wrote:
>>
>>>> Thomas Petazzoni (6):
>>>>   dt-bindings: interrupt-controller: add DT binding for the Marvell GICP
>>>>   dt-bindings: interrupt-controller: add DT binding for the Marvell ICU
>>>>   irqchip: irq-mvebu-gicp: new driver for Marvell GICP
>>>>   irqchip: irq-mvebu-icu: new driver for Marvell ICU
>>>>   arm64: marvell: enable ICU and GICP drivers
>>>>   arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K
>>>>
>>>>  .../bindings/interrupt-controller/marvell,gicp.txt |  27 ++
>>>>  .../bindings/interrupt-controller/marvell,icu.txt  |  51 ++++
>>>>  arch/arm64/Kconfig.platforms                       |   2 +
>>>>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   7 +
>>>>  .../boot/dts/marvell/armada-cp110-master.dtsi      |  59 +++--
>>>>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  55 ++--
>>>>  drivers/irqchip/Kconfig                            |   6 +
>>>>  drivers/irqchip/Makefile                           |   2 +
>>>>  drivers/irqchip/irq-mvebu-gicp.c                   | 279 ++++++++++++++++++++
>>>>  drivers/irqchip/irq-mvebu-gicp.h                   |  12 +
>>>>  drivers/irqchip/irq-mvebu-icu.c                    | 289 +++++++++++++++++++++
>>>>  .../dt-bindings/interrupt-controller/mvebu-icu.h   |  15 ++
>>>>  12 files changed, 756 insertions(+), 48 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
>>>>  create mode 100644 drivers/irqchip/irq-mvebu-gicp.c
>>>>  create mode 100644 drivers/irqchip/irq-mvebu-gicp.h
>>>>  create mode 100644 drivers/irqchip/irq-mvebu-icu.c
>>>>  create mode 100644 include/dt-bindings/interrupt-controller/mvebu-icu.h
>>>>   
>>>
>>> It all looks good to me. How do we merge this? I take the first five
>>> patches and Gregory takes the last one?
>>
>> I think you should take the first four patches, and Gr?gory takes the
>> last two ones. But I'll let Gr?gory confirm.
> 
> Indeed it makes more sens to merge the patch 4 through the arm-soc
> subsystem.

Hmmm. You mean patches 5 and 6, right? And I queue 1 to 4?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
