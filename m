From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 14 Jun 2012 15:59:02 +0200
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfYMxSKmGAvZ5ucNyr8AL0zBAj5jpt+s8YhogKaWdv2mAw@mail.gmail.com>
 (Josh Coombs's message of "Thu, 14 Jun 2012 09:28:24 -0400")
References: <CAMW5Ufar3+RFwwmPd5xS_aNBKz6VLyDnw_3_aJDOR-xRz1kkTw@mail.gmail.com>
 <20120613191029.GI14756@titan.lakedaemon.net>
 <CAMW5UfYMxSKmGAvZ5ucNyr8AL0zBAj5jpt+s8YhogKaWdv2mAw@mail.gmail.com>
Message-ID: <87zk86vvtl.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh Coombs <josh.coombs@gmail.com> writes:

> On Wed, Jun 13, 2012 at 3:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>
>> I would recommend looking at how we did the first board, the dreamplug.
>> Files of interest are:
>>
>> arch/arm/boot/dts/kirkwood.dtsi
>> arch/arm/boot/dts/kirkwood-dreamplug.dts
>> arch/arm/mach-kirkwood/board-dt.c
>> arch/arm/mach-kirkwood/board-dreamplug.c
>> arch/arm/mach-kirkwood/Kconfig
>> arch/arm/mach-kirkwood/Makefile
>> arch/arm/mach-kirkwood/Makefile.boot
>>
>> commit 3d468b6 seems to be a good place to start.
>>
>> For your first patch series, use the dtb to tell the kernel what board
>> it is on. ?Once that's working, then you just start coverting over
>> drivers one by one. ?Several are already done.
>>
>> hth,
>>
>> Jason.
>
> First pass didn't boot, no kernel messages.  I'm going to go through
> the ArchLinux ARM superpatch to see if there are any items not
> directly pegged to the GoFlex that might be involved next, as well as
> cutting my conf down to just what's needed for the GFN to cut down my
> build times.  While I'm doing that, what do I NEED to configure for
> proper DTS support?
>
> CONFIG_ARCH_KIRKWOOD=y
>
> CONFIG_ARCH_KIRKWOOD_DT=y
> CONFIG_MACH_DREAMPLUG_DT=n
> CONFIG_MACH_ICONNECT_DT=n
> CONFIG_MACH_DLINK_KIRKWOOD_DT=n
> CONFIG_MACH_IB62X0_DT=n
> CONFIG_MACH_GOFLEX_DT=y
>
> CONFIG_USE_OF=y
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_CMDLINE=""
> CONFIG_ATAGS_PROC=y
>
> CONFIG_USE_OF=y
> CONFIG_MTD_OF_PARTS=y
> # CONFIG_MTD_PHYSMAP_OF is not set
> CONFIG_OF=y
> # CONFIG_OF_SELFTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_DEVICE=y
> CONFIG_OF_I2C=m
> CONFIG_OF_NET=y
> CONFIG_OF_MDIO=y
> CONFIG_OF_PCI=y
> CONFIG_OF_PCI_IRQ=y
> CONFIG_OF_MTD=y
> # CONFIG_SERIAL_OF_PLATFORM is not set

You should enable this one if you want to use the serial port.

Arnaud
