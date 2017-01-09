From: alexgershgorin@gmail.com (Alex Gershgorin)
Date: Mon, 9 Jan 2017 17:10:34 +0200
Subject: mmc: sdhci-of-at91: Internal clock never stabilised
In-Reply-To: <20170109135855.dquiysi5wnilujgp@rfolt0960.corp.atmel.com>
References: <1DC01DCD0F70AE4284AE3A5E8C726E225D20EDF1@Ex2010.q-core.co.il>
 <CAJP5LRNRSpMjdTFyL4R4ZN1tZAG0A=TKR5LRareg+TEJmnkd2Q@mail.gmail.com>
 <20170108125344.3iyfoodszupzgukk@piout.net>
 <20170109071900.fz2en246i7uqmavw@rfolt0960.corp.atmel.com>
 <CAJP5LRMjVGWpHE5K8xZOb=m2wxy8qRxx5_BbLFEHuA13Rh_WoQ@mail.gmail.com>
 <20170109135855.dquiysi5wnilujgp@rfolt0960.corp.atmel.com>
Message-ID: <CAJP5LROuAg1xc1q8LpJ7QjynKBfYrvpjX8Jn54LmkCFMENo1uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your help, I will replace the chip with Rev B so I can
indeed start working on my board normally J

Regards,
Alex

On Mon, Jan 9, 2017 at 3:58 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Mon, Jan 09, 2017 at 12:44:42PM +0200, Alex Gershgorin wrote:
>> Hi Ludovic,
>> As we read the chip ID from CHIPID_CIDR register we get 0x8a5c08c0 (we
>> use ATSAMA5D27A-CU).
>>
>
> It seems the device you have is a rev A device, this issue should be fixed in
> the revision B.
>
> I say should, because the bug was identified and I provided a workaround with
> the use of our own set_clock function has been done. Unfortunately, even
> if it happens less frequently, it seems the bug is still here.
>
> The hardware part has been reworked on the revision B. I don't recall facing
> this issue again but I can't guarantee that it won't happen anymore
> since the root cause was not properly identified on rev A.
>
> Regards
>
> Ludovic
>
>>
>> Thanks,
>> Alex
>>
>> On Mon, Jan 9, 2017 at 9:19 AM, Ludovic Desroches
>> <ludovic.desroches@atmel.com> wrote:
>> > Hi Alex,
>> >
>> > Which revision of SoC are you using?
>> >
>> > Regards
>> >
>> > Ludovic
>> >
>> > On Sun, Jan 08, 2017 at 01:53:44PM +0100, Alexandre Belloni wrote:
>> >> Hi,
>> >>
>> >> I think Cyrille worked on that a few month ago, maybe he has a comment.
>> >>
>> >> On 08/01/2017 at 14:07:53 +0200, Alex Gershgorin wrote :
>> >> > Hi All,
>> >> > We have two different HW platforms based on SAMA5D2 SoC (SAMA5D2 Xplained
>> >> > Board and our own HW).
>> >> > On both of them we are facing stabilization of the internal
>> >> > clock problem, it does not happen all the time but quite often.
>> >> > Please see below my Kernel boot messages:
>> >> >
>> >> > sdhci: Copyright(c) Pierre Ossman
>> >> > sdhci-pltfm: SDHCI platform and OF driver helper
>> >> > sdhci-at91 a0000000.sdio-host: update clk mul to 39 as gck rate is
>> >> > 480000000 Hz
>> >> > mmc0: Internal clock never stabilised.
>> >> > mmc0: Internal clock never stabilised.
>> >> > mmc0: SDHCI controller on a0000000.sdio-host [a0000000.sdio-host] using ADMA
>> >> >
>> >> > snip
>> >> >
>> >> > snip
>> >> >
>> >> > Waiting for root device /dev/mmcblk0p2...
>> >> > mmc0: Internal clock never stabilised.
>> >> > mmc0: Timeout waiting for hardware cmd interrupt.
>> >> > sdhci: =========== REGISTER DUMP (mmc0)===========
>> >> > sdhci: Sys addr: 0x00000000 | Version:  0x00001502
>> >> > sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
>> >> > sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
>> >> > sdhci: Present: 0x01ff0001 | Host ctl: 0x00000001
>> >> > sdhci: Power: 0x0000000f | Blk gap:  0x00000000
>> >> > sdhci: Wake-up: 0x00000000 | Clock:    0x0000ffe1
>> >> > sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
>> >> > sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
>> >> > sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>> >> > sdhci: Caps: 0x27ec0c8c | Caps_1: 0x00270f77
>> >> > sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
>> >> > sdhci: Host ctl2: 0x00000000
>> >> > sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
>> >> > sdhci: ===========================================
>> >> >
>> >> > Any direction to solve this problem?
>> >> >
>> >> > Thanks,
>> >> > Alex Gershgorin
>> >>
>> >> --
>> >> Alexandre Belloni, Free Electrons
>> >> Embedded Linux and Kernel engineering
>> >> http://free-electrons.com
>> >>
>> >> _______________________________________________
>> >> linux-arm-kernel mailing list
>> >> linux-arm-kernel at lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
