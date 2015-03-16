From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 16 Mar 2015 17:01:10 +0100
Subject: [PATCH 0/3] Add DT support for netxbig LEDs
In-Reply-To: <20150309094107.GL1509@kw.sim.vm.gnt>
References: <1424703861-20903-1-git-send-email-simon.guinot@sequanux.org>
 <20150309094107.GL1509@kw.sim.vm.gnt>
Message-ID: <5506FE46.4000405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 09/03/2015 10:41, Simon Guinot wrote:
> On Mon, Feb 23, 2015 at 04:04:18PM +0100, Simon Guinot wrote:
>> Hello,
>>
>> This patch series adds DT support for the LEDs found on the Kirkwood-based
>> LaCie boards 2Big and 5Big Network v2.
>>
>> Simon
>>
>> Simon Guinot (3):
>>   leds: netxbig: add device tree binding
>>   ARM: Kirkwood: add LED DT entries for netxbig boards
>>   ARM: mvebu: remove static LED setup for netxbig boards
> 
> Hi Brian,
> 
> Please, consider merging the first patch of this serie.

Brian,

here again let me know when this patch will be merged, and I will
also need a stable tag as patch 2 depends on this one.

Andrew, Jason,

patch 2 and 3 looks OK for me. What is your opinion about it?


Thanks,

Gregory




> 
> Thanks in advance.
> 
> Simon
> 
>>
>>  .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>>  .../devicetree/bindings/leds/leds-netxbig.txt      |  90 ++++++++
>>  arch/arm/boot/dts/kirkwood-net5big.dts             |  60 +++++
>>  arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 +++++++
>>  arch/arm/mach-mvebu/Kconfig                        |   7 -
>>  arch/arm/mach-mvebu/Makefile                       |   1 -
>>  arch/arm/mach-mvebu/board.h                        |  21 --
>>  arch/arm/mach-mvebu/kirkwood.c                     |   4 -
>>  arch/arm/mach-mvebu/netxbig.c                      | 191 ----------------
>>  drivers/leds/leds-netxbig.c                        | 244 +++++++++++++++++++--
>>  include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>>  11 files changed, 493 insertions(+), 245 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>  delete mode 100644 arch/arm/mach-mvebu/board.h
>>  delete mode 100644 arch/arm/mach-mvebu/netxbig.c
>>  create mode 100644 include/dt-bindings/leds/leds-netxbig.h
>>
>> -- 
>> 2.1.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
