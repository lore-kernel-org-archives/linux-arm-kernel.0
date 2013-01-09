From: monstr@monstr.eu (Michal Simek)
Date: Wed, 9 Jan 2013 17:52:13 +0100
Subject: arm NO_IRQ = -1 - zynq axi_ethernet driver
In-Reply-To: <50E58E73.6070308@gmail.com>
References: <CAHTX3d+dOm2AzK=g_UbEiJ2AQYJNJtfWHXGvrxK1TqM2nmEh7Q@mail.gmail.com>
 <50E58E73.6070308@gmail.com>
Message-ID: <CAHTX3dKu_8gTL+z-ZNhJV+RhaTRU7hqAL7oA0A5a1A628x=7RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/3 Rob Herring <robherring2@gmail.com>:
> On 01/03/2013 07:47 AM, Michal Simek wrote:
>> Hi Grand, Russell, Arnd, Olof and Rob,
>>
>> I am getting one problem with axi_ethernet driver because I want to remove
>> NO_IRQ from axi_ethernet driver because NO_IRQ was setup to 0 and
>> removed from microblaze long time ago.
>> Some patches from reference.
>> "microblaze: Change NO_IRQ to 0"
>> sha1: 6c7a2676f594ca9a30203b4fd5dc26b53682cffe
>> and
>> "microblaze: Remove NO_IRQ from architecture"
>> sha1: 18e3b1075b1bc4a6027a6612fe70a5c81c209ec7
>>
>> but we can also use this driver on arm Zynq platform.
>> It is easy to add
>> #ifndef NO_IRQ
>> #define NO_IRQ 0
>> #endif
>> to the driver to cover Microblaze case but it will be just workaround.
>>
>> From patches description NO_IRQ shouldn't be used by any driver
>> + from Grant description
>>
>> "As has been discussed many times[1], Using NO_IRQ set to anything other
>> than 0 is bug waiting to happen since many drivers follow the pattern
>> "if (!irq)" for testing whether or not an irq has been set."
>>
>> + link
>> [1] http://lkml.org/lkml/2005/11/21/221
>>
>> Was there any attempt to remove NO_IRQ from ARM?
>> Any problem to do it?
>
> It's not removed, but we've trimmed it out of most things. It appears
> that drivers are mostly not using it other than powerpc drivers. It is
> not really necessary to remove it from the arch. Drivers should simply
> check for (irq <= 0) for error cases. I'm not sure if there are any
> platforms left using irq 0 as a valid irq.

Unfortunately microblaze system can use any IRQ number but MB NO_IRQ is 0
that's why it shouldn't hurt because on ARM axi ethernet can't be on IRQ 0.

Thanks for hint,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
