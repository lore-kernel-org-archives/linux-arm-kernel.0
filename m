From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 11:57:16 +0100
Subject: [PATCH 1/8] arm: mach-armada: add headers
In-Reply-To: <20120515091620.GC1721@trinity.fluff.org>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091620.GC1721@trinity.fluff.org>
Message-ID: <4FB2368C.8010807@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 10:16, Ben Dooks wrote:
> On Tue, May 15, 2012 at 10:54:37AM +0200, Thomas Petazzoni wrote:
>> From: Gregory CLEMENT<gregory.clement@free-electrons.com>
>>
>> This patch adds basic header files for Armada SoCs.
>>
>> Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Lior Amsalem<alior@marvell.com>
>> ---
>>   arch/arm/mach-armada/include/mach/armada.h      |  234 +++++++++++++++++++++++
>>   arch/arm/mach-armada/include/mach/bridge-regs.h |   28 +++
>>   arch/arm/mach-armada/include/mach/debug-macro.S |   23 +++
>>   arch/arm/mach-armada/include/mach/gpio.h        |   13 ++
>>   arch/arm/mach-armada/include/mach/hardware.h    |   18 ++
>>   arch/arm/mach-armada/include/mach/io.h          |   24 +++
>>   arch/arm/mach-armada/include/mach/irqs.h        |   96 ++++++++++
>>   arch/arm/mach-armada/include/mach/system.h      |   21 ++
>>   arch/arm/mach-armada/include/mach/timex.h       |   13 ++
>>   arch/arm/mach-armada/include/mach/uncompress.h  |   41 ++++
>>   10 files changed, 511 insertions(+)
>>   create mode 100644 arch/arm/mach-armada/include/mach/armada.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/bridge-regs.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/debug-macro.S
>>   create mode 100644 arch/arm/mach-armada/include/mach/gpio.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/hardware.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/io.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/irqs.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/system.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/timex.h
>>   create mode 100644 arch/arm/mach-armada/include/mach/uncompress.h
>>
>> diff --git a/arch/arm/mach-armada/include/mach/armada.h b/arch/arm/mach-armada/include/mach/armada.h
>> new file mode 100644
>> index 0000000..be12667
>> --- /dev/null
>> +++ b/arch/arm/mach-armada/include/mach/armada.h
>> @@ -0,0 +1,234 @@
>> +/*
>> + * Generic definitions for Marvell Armada SoCs
>> + *
>> + * Copyright (C) 2012 Marvell
>> + *
>> + * Lior Amsalem<alior@marvell.com>
>> + * Gregory CLEMENT<gregory.clement@free-electrons.com>
>> + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __MACH_ARMADA_H
>> +#define __MACH_ARMADA_H
>> +
>> +/*
>> + * Marvell ARMADA address maps.
>> + *
>> + * phys		virt		size
>> + * d0000000	feb00000	1M	internal registers
>> + * d0100000	@runtime	1M	uart
>> + * d0200000	fec00000	1M	PCIe-0 I/O (port 0.0)
>> + * d0300000	fed00000	1M	PCIe-1 I/O (port 1.0)
>> + * d0400000	fee00000	1M	PCIe-2 I/O (port 2.0)
>> + * d0500000	fef00000	1M	PCIe-3 I/O (port 3.0)
>> + * d0600000	@runtime	1M	cryptographic sram-0
>> + * d0700000	@runtime	1M	cryptographic sram-1
>> + * d0800000	reserved	8M	reserved for future
>> + * d1000000	@runtime	16M	device bus cs-0
>> + * d2000000	@runtime	16M	device bus cs-0
>> + * d3000000	@runtime	16M	device bus cs-0
>> + * d4000000	@runtime	16M	device bus cs-0
>> + * d5000000	@runtime	16M	device bus boot cs
>> + * d6000000	@runtime	16M	spi-0 flash
>> + * d7000000	@runtime	16M	spi-1 flash
>> + * d8000000	@runtime	64M	PCIe-0 Memory (port 0.0)
>> + * dc000000	@runtime	64M	PCIe-1 Memory (port 1.0)
>> + * e0000000	@runtime	64M	PCIe-2 Memory (port 2.0)
>> + * e4000000	@runtime	64M	PCIe-3 Memory (port 3.0)
>> + * fff00000	@runtime	1M	internal bootrom
>> + */

I think these mappings are mostly un-necessary at initialisation time
and secondly the support merged so far does not need most of these. I
would say that the PCIe and SPI should be dynamically mapped when they
are instantiated from the device tree.

Second comment, why do we have two sets of UART mappings, one from the
internal registers and the second from its own phys space?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
