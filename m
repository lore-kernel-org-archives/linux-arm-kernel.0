From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Fri, 7 Feb 2014 10:36:02 +0100
Subject: [PATCH v3 00/15] Device Tree support for the at91sam9261ek
In-Reply-To: <20140207083304.GX9558@ns203013.ovh.net>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
 <20140207083304.GX9558@ns203013.ovh.net>
Message-ID: <CACh+v5Mpd4eKkCmdotqt6cMbLZ-RUvDpLo0YCe0TFacatAAQKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-07 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> Hi,
>
>         please re-organise your patch serie
>
>         first SoC patch
>           - first CCF
>           - one patch for the SoC
>         second add the board 1 patch
>
>         no need 15 patches
>
> Best Regards,
> J.
I don't know about this. It's always easier for the review and bug
chasing to keep the patch separated. It would make my task easier
though.
I'll wait for the feedback of Nicolas on this.

> On 16:57 Thu 23 Jan     , Jean-Jacques Hiblot wrote:
>> This patch set aims at bringing a basic device tree support for the sam9261.
>> It's mostly based on the sam9263 and sam9x5 stuff.
>>
>> Changes since V2:
>> * removed the smc driver from the serie. It'll be posted in an independent
>>   serie later.
>> * removed the DM9000 support (it'll come with the smc driver)
>> * the sam9261 now supports the Common Clock Framework (CCF). Note: to enable
>>   the CCF you must remove from the kernel config the platforms that don't
>>   support it.
>> * Added basic DT binding for the bus matrix
>> * Added support for USB host
>> * Added support for USB gadget
>> * in dts(i), replaced interrupt-parent with interrupts-extended
>> * changed the nand partition plan (same as for the sama5d3)
>> * removed 'mem' parameter in command line
>> * re-ordered dt-nodes in ascending address order.
>> * split the lcd support patch in 2 parts (SOC and board)
>>
>>
>> Change since V1:
>> * changed the DT representation to use address translation and separate the
>>   timings' configuration from the device properties by adding a "simple-bus"
>>   inetrmediate node.
>> * moved the smc driver from drivers/bus to drivers/memmory
>> * smc driver now accepts timings in nanoseconds as well as raw register values
>> * smc driver can clip the timings if they're out of bound and dump them to the
>>   console
>> * DM9000 timings are now described in nanosecs (for the virtue of example)
>>
>> supported features:
>> * dbgu
>> * nand
>> * lcd
>> * leds
>> * user buttons
>> * usb host
>> * usb gadget
>>
>> This serie relies on the 3 following patchs:
>> usb: ohci-at91: fix irq and iomem resource retrieval
>> usb: at91-udc: fix irq and iomem resource retrieval
>> ARM: at91: prepare sam9 dt boards transition to common
>>
>> Jean-Jacques
>>
>>
>>
>> Jean-Jacques Hiblot (15):
>>   at91: dt: Add at91sam9261 dt SoC support
>>   at91: dt: defconfig: Added the sam9261 to the list of supported SOCs
>>   at91: dt: sam9261: Basic Device Tree support for the at91sam9261ek
>>   ARM: at91: prepare common clk transition for sam9261 SoC
>>   ARM: at91: move sam9261 SoC to common clk
>>   at91: dt: at91sam9261ek: Adds DT entries for the 4 user buttons
>>   at91: dt: sam9261: Added the descriptions of hck0 and hck1 clocks
>>     (CCF)
>>   at91: dt: sam9261: Added hclk declaration for the fb driver (non-CCF)
>>   at91: dt: sam9261: Added support for the LCD display
>>   at91: dt: at91sam9261ek: Added support for the LCD display
>>   at91: dt: Adds support for the bus matrix declaration in the device
>>     tree
>>   at91: dt: sam9261: adds description for the bus matrix
>>   at91: dt: sam9261: CCF: Added USB clocks
>>   at91: dt: at91sam9261ek: Enabled the USB host port (OHCI)
>>   at91: dt: at91sam9261ek: Enabled the USB device port
>>
>>  arch/arm/boot/dts/Makefile          |   2 +
>>  arch/arm/boot/dts/at91sam9261.dtsi  | 724 ++++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/at91sam9261ek.dts | 191 ++++++++++
>>  arch/arm/configs/at91_dt_defconfig  |   1 +
>>  arch/arm/mach-at91/Kconfig          |   1 -
>>  arch/arm/mach-at91/at91sam9261.c    |  24 +-
>>  arch/arm/mach-at91/setup.c          |  23 ++
>>  7 files changed, 963 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/at91sam9261.dtsi
>>  create mode 100644 arch/arm/boot/dts/at91sam9261ek.dts
>>
>> --
>> 1.8.5.2
>>
