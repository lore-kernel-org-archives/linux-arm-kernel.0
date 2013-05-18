From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sat, 18 May 2013 14:28:57 -0300
Subject: ARM: 3.10-rc1 does not boot anymore on OpenBlocks AX3
In-Reply-To: <20130518172633.GD1936@1wt.eu>
References: <20130518170158.GB1936@1wt.eu> <20130518172212.GA21837@localhost>
 <20130518172633.GD1936@1wt.eu>
Message-ID: <CALF0-+UfQeh-vKMmm7Eehbw6MNtouL0i+BceC2zVmBk5s7QfGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 2:26 PM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Gregory & Ezequeil,
>
> On Sat, May 18, 2013 at 02:22:13PM -0300, Ezequiel Garcia wrote:
>> Hi Willy,
>>
>> On Sat, May 18, 2013 at 07:01:58PM +0200, Willy Tarreau wrote:
>> >
>> > Uncompressing Linux... done, booting the kernel.
>> > Booting Linux on physical CPU 0x0
>> > Linux version 3.10.0-rc-mvebu (willy at pcw) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG 1.18.0) ) #6 SMP Sat May 18 17:40:55 CEST 2013
>> > CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
>> > CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>> > Machine: Marvell Armada 370/XP (Device Tree), model: PlatHome OpenBlocks AX3-4 board
>> > bootconsole [earlycon0] enabled
>> > INITRD: 0x07000040+0x00a5c000 is not a memory region - disabling initrd
>> > Memory policy: ECC disabled, Data cache writealloc
>> > Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
>>
>> This is a known issue.
>> Please try again with this patch:
>>
>> [PATCH] ARM: zImage: Convert 32bits memory size and address from ATAG to
>> 64bits DTB
>>
>> which has been posted on LAKML on May 14th.
>
> Thanks to you both for your simultaneous response :-)

That's because our mvebu stuff has enabled parallel user support :-)
-- 
    Ezequiel
