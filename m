From: minggr@gmail.com (Lin Ming)
Date: Sat, 6 Jul 2013 00:52:56 +0800
Subject: kernel decompressor problem for ARMv7
In-Reply-To: <20130705095757.GA13063@mudshark.cambridge.arm.com>
References: <CAF1ivSakn8-HiAf+4_cLRWUUTDP9QBKpAt+hVQoMyAmKZ2-dJA@mail.gmail.com>
 <20130705095757.GA13063@mudshark.cambridge.arm.com>
Message-ID: <CAF1ivSYzvurfUoM-+UNEhUQz9v5uBbtr20zjv0u6veG1XYoqUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 5, 2013 at 5:57 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 05, 2013 at 09:44:12AM +0100, Lin Ming wrote:
>> Hi all,
>
> Hello,
>
>> I'm porting BSP code from v2.6.36 to v3.10 kernel. It's ARMv7 processor.
>
> Which specific processor/SoC?

Cortex-A9 CPU on Cortina-Systems Baseboard

>
>> But decompressor doesn't work. With a lot of debug, I finally find
>> below 2 commits related.
>> Kernel uncompress OK with these commits reverted.
>>
>> dbece45: ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores
>> (Introduced in v3.6-rc6)
>>
>> 5010192: ARM: 7583/1: decompressor: Enable unaligned memory access for
>> v6 and above
>> (Introduced in v3.7-rc8)
>>
>> Any hint to fix it?
>
> There's not really enough information to go on here. What specifically
> fails? Also, do you have to revert *both* of the above changes to get things
> working again?

The "fails" is that the decompressor code never get called.
U-Boot prints "Starting kernel", then the board just hang there.

Yes, need to revert *both*.

>
> Cheers,
>
> Will
