From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 16 Aug 2017 09:22:48 -0500
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Add support for rev C
In-Reply-To: <bf2a5868-4c0b-58a1-350e-cba7dcfb5166@ti.com>
References: <20170814175820.12065-1-robertcnelson@gmail.com>
 <bf2a5868-4c0b-58a1-350e-cba7dcfb5166@ti.com>
Message-ID: <CAOCHtYi=JxMirp03DMny+HFo3g9nsPO--VuNK7N-YtctNhj2dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 10:11 PM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
>
> On Monday 14 August 2017 11:28 PM, Robert Nelson wrote:
>> Latest update to the BeagleBoard-X15 platform (revision C). This board contains
>> a silicon update (Rev 2.0), which includes a fix for the 2nd ethernet phy when
>> running at 1000 Mbps speeds.
>>
>> This board can be indentified by the [C.00] after [BBRDX15_] in the at24 eeprom:
>> [BBRDX15_C.001731PX150249]
>>
>> Rev C is now in full production and boards are available for end users.
>>
>> https://beagleboard.org/x15
>> https://github.com/beagleboard/beagleboard-x15/
>>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> CC: Nishanth Menon <nm@ti.com>
>> CC: Jason Kridner <jkridner@beagleboard.org>
>> CC: Drew Fustini <drew@beagleboard.org>
>> ---
>>  arch/arm/boot/dts/Makefile                   |  1 +
>>  arch/arm/boot/dts/am57xx-beagle-x15-revc.dts | 24 ++++++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index c293e841eea3..d3a4fe7eb6f7 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -651,6 +651,7 @@ dtb-$(CONFIG_SOC_OMAP5) += \
>>  dtb-$(CONFIG_SOC_DRA7XX) += \
>>       am57xx-beagle-x15.dtb \
>>       am57xx-beagle-x15-revb1.dtb \
>> +     am57xx-beagle-x15-revc.dtb \
>>       am57xx-cl-som-am57x.dtb \
>>       am57xx-sbc-am57x.dtb \
>>       am572x-idk.dtb \
>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
>> new file mode 100644
>> index 000000000000..742eeb96b8aa
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Copyright (C) 2014-2016 Texas Instruments Incorporated - http://www.ti.com/
>                                                 ^^2017 :)
>
> Rest of the patch looks good to me.
>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
>
> Thanks and regards,
> Lokesh

and this is going to conflict with:

[v2,04/10] ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC

https://patchwork.kernel.org/patch/9903875/

i'll wait for Tony to pick up Kishon's before i re-submit..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
