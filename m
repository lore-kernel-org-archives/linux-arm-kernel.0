From: robherring2@gmail.com (Rob Herring)
Date: Thu, 03 Jan 2013 16:09:43 -0600
Subject: [PATCH v4 10/19] irqchip: Move ARM gic.h to
 include/linux/irqchip/arm-gic.h
In-Reply-To: <201301032144.52079.arnd@arndb.de>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-11-git-send-email-robherring2@gmail.com>
 <201301032144.52079.arnd@arndb.de>
Message-ID: <50E601A7.8010801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 03:44 PM, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Now that we have GIC moved to drivers/irqchip and all GIC DT init for
>> platforms using irqchip_init, move gic.h and update the remaining
>> includes.
> 
> Can you elaborate on why this is done? Does any other code rely on the
> header file being globally visible, or is there a more general reason
> to move header files out of asm/ ?

KVM needs the register definitions for GIC distributor emulation.
Platform SMP code still needs gic_secondary_init. Non-DT platform init
still needs gic_init. And Russell did not like it being left in arch/arm
with the rest moved out.

Rob
