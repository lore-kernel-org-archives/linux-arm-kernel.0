From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Sat, 25 Jul 2015 21:36:22 +0200
Subject: [PATCH v2 0/3] Add DT support for netxbig LEDs
In-Reply-To: <55B3A32C.1010305@free-electrons.com>
References: <1434628373-11834-1-git-send-email-simon.guinot@sequanux.org>
 <55B3A32C.1010305@free-electrons.com>
Message-ID: <55B3E536.5010107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 25.07.2015 16:54, Gregory CLEMENT wrote:
> Hi Simon, Bryan, Richard,
>
> On 18/06/2015 13:52, Simon Guinot wrote:
>> Hello,
>>
>> This patch series adds DT support for the LEDs found on the Kirkwood-based
>> LaCie boards 2Big and 5Big Network v2.
>
> I saw that some led related patch on kirkwood based board have been merged.
> What is the status of this series?

LED subsystem part has been merged to linux-next, since DTS files
are not required for the compilation to succeed. We've been waiting
for ARM/Marvell Kirkwood maintainer opinion to decide on how to proceed
regarding patch 2/4.

> I still have the patch 2 and 3 in my inbox waiting for being applied.

Patch 3 affects only drivers/leds/leds-ns2.c, you were probably
thinking of patch 1 which modifies the out of LED tree file
include/linux/platform_data/leds-kirkwood-ns2.h.

IMO it would be best if the whole series went through the
LED tree.

> Thanks,
>
> Gregory
>
>
>>
>> Changes since v1:
>> - Check timer mode value retrieved from DT.
>> - In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
>>    timer delay values from DT with function of_property_read_u32_index.
>>    Instead, use a temporary u32 variable. This allows to silence a static
>>    checker warning.
>> - Make timer property optional in the binding documentation. It is now
>>    aligned with the driver code.
>>
>> Simon
>>
>> Simon Guinot (3):
>>    leds: netxbig: add device tree binding
>>    ARM: Kirkwood: add LED DT entries for netxbig boards
>>    ARM: mvebu: remove static LED setup for netxbig boards
>>
>>   .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>>   .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
>>   arch/arm/boot/dts/kirkwood-net5big.dts             |  60 +++++
>>   arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 +++++++
>>   arch/arm/mach-mvebu/Kconfig                        |   7 -
>>   arch/arm/mach-mvebu/Makefile                       |   1 -
>>   arch/arm/mach-mvebu/board.h                        |  21 --
>>   arch/arm/mach-mvebu/kirkwood.c                     |   4 -
>>   arch/arm/mach-mvebu/netxbig.c                      | 191 ----------------
>>   drivers/leds/leds-netxbig.c                        | 250 +++++++++++++++++++--
>>   include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>>   11 files changed, 501 insertions(+), 245 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>   delete mode 100644 arch/arm/mach-mvebu/board.h
>>   delete mode 100644 arch/arm/mach-mvebu/netxbig.c
>>   create mode 100644 include/dt-bindings/leds/leds-netxbig.h
>>
>
>

-- 
Best Regards,
Jacek Anaszewski
