From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Jun 2017 17:42:18 +0200
Subject: [PATCH v5 0/6] Add support for the ICU unit in Marvell Armada
 7K/8K
In-Reply-To: <20170621171809.34bcce1e@windsurf.home> (Thomas Petazzoni's
 message of "Wed, 21 Jun 2017 17:18:09 +0200")
References: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
 <e87dc80c-f85c-1b20-c2e8-cd03922dacd9@arm.com>
 <20170621171809.34bcce1e@windsurf.home>
Message-ID: <87r2yd1h5x.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc and Thomas,
 
 On mer., juin 21 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed, 21 Jun 2017 16:14:21 +0100, Marc Zyngier wrote:
>
>> > Thomas Petazzoni (6):
>> >   dt-bindings: interrupt-controller: add DT binding for the Marvell GICP
>> >   dt-bindings: interrupt-controller: add DT binding for the Marvell ICU
>> >   irqchip: irq-mvebu-gicp: new driver for Marvell GICP
>> >   irqchip: irq-mvebu-icu: new driver for Marvell ICU
>> >   arm64: marvell: enable ICU and GICP drivers
>> >   arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K
>> > 
>> >  .../bindings/interrupt-controller/marvell,gicp.txt |  27 ++
>> >  .../bindings/interrupt-controller/marvell,icu.txt  |  51 ++++
>> >  arch/arm64/Kconfig.platforms                       |   2 +
>> >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   7 +
>> >  .../boot/dts/marvell/armada-cp110-master.dtsi      |  59 +++--
>> >  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  55 ++--
>> >  drivers/irqchip/Kconfig                            |   6 +
>> >  drivers/irqchip/Makefile                           |   2 +
>> >  drivers/irqchip/irq-mvebu-gicp.c                   | 279 ++++++++++++++++++++
>> >  drivers/irqchip/irq-mvebu-gicp.h                   |  12 +
>> >  drivers/irqchip/irq-mvebu-icu.c                    | 289 +++++++++++++++++++++
>> >  .../dt-bindings/interrupt-controller/mvebu-icu.h   |  15 ++
>> >  12 files changed, 756 insertions(+), 48 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
>> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
>> >  create mode 100644 drivers/irqchip/irq-mvebu-gicp.c
>> >  create mode 100644 drivers/irqchip/irq-mvebu-gicp.h
>> >  create mode 100644 drivers/irqchip/irq-mvebu-icu.c
>> >  create mode 100644 include/dt-bindings/interrupt-controller/mvebu-icu.h
>> >   
>> 
>> It all looks good to me. How do we merge this? I take the first five
>> patches and Gregory takes the last one?
>
> I think you should take the first four patches, and Gr?gory takes the
> last two ones. But I'll let Gr?gory confirm.

Indeed it makes more sens to merge the patch 4 through the arm-soc
subsystem.

Thanks,

Gregory
>
> Once again, thanks a lot for your help on this series, it's in a much
> better shape now compared to what the original submission was!
>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
