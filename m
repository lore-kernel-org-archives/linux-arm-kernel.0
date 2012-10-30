From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Oct 2012 11:05:48 -0500
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <20121030160129.7e39619b@skate>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate>
Message-ID: <508FFADC.3080506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 10:01 AM, Thomas Petazzoni wrote:
> Rob,
> 
> On Tue, 30 Oct 2012 09:54:18 -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Now that we have drivers/irqchip, move GIC irqchip to drivers/irqchip. This
>> is necessary to share the GIC with arm and arm64.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  arch/arm/common/Kconfig                            |    8 --------
>>  arch/arm/common/Makefile                           |    1 -
>>  drivers/irqchip/Kconfig                            |    8 ++++++++
>>  drivers/irqchip/Makefile                           |    1 +
>>  arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
>>  drivers/irqchip/irqchip.c                          |   10 ++++++++++
>>  drivers/irqchip/irqchip.h                          |    1 +
>>  7 files changed, 20 insertions(+), 9 deletions(-)
> 
> What about arch/arm/include/asm/hardware/gic.h ?
> 
> Contrary to the current version of the bcm2835 IRQ controller driver
> and the armada-370-xp IRQ controller driver, the GIC and VIC drivers
> not only expose a <foo>_of_init() function, but also other functions
> that are directly used by several non-DT capable ARM sub-architectures.
> 
> Of course, it works by leaving gic.h where it is now, but it sounds
> strange to have the driver in drivers/irqchip/ and the header file in
> arch/arm/include/asm/hardware/, especially if the goal is to be able to
> use those drivers in arm64.

Right. I'll have to move it. I wasn't really thinking about arm64 until
this morning.

Rob
