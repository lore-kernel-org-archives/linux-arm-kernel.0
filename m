From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Dec 2014 17:26:43 -0600
Subject: kernel.org - master not booting on keystone (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <54949FEE.8070808@ti.com>
References: <549490D6.3090804@ti.com> <20141219211816.GH10857@pengutronix.de>
 <54949FEE.8070808@ti.com>
Message-ID: <CAGo_u6r58LriBAWeuG7NO0VFJ7rnrNbuKymQPRU-H9CvSyBnbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 4:00 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 12/19/2014 04:18 PM, Uwe Kleine-K?nig wrote:
>>
>> Hello,
>>
>> On Fri, Dec 19, 2014 at 03:55:50PM -0500, Murali Karicheri wrote:
>>>
>>> I have pulled the latest master from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
>>> tried booting on keystone k2hk and k2e EVM. The boot hangs with
>>> following log. Has anyone seen this? Keystone is an ARM v7 cortex
>>> A15 SMP platform. I am assuming master branch is broken for ARM v7
>>> and someone is working to address this. v3.18 booted up fine on my
>>> EVM.
>>>
>>> Any idea?
>>
>> You forgot to attach the log?! So no, I don't have any idea. Did you
>> bisect?
>>
>> Best regards
>> Uwe
>>
> Just see below if I enable debug earlyprintk
>
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.18.0-11757-gd790be3 (a0868495 at ares-ubuntu)
> (gcc version 4.7.3 20130226 (prerelease) (crosstool-NG
> linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03) ) #1 SMP PREEMPT
> Fri Dec 19 15:53:47 EST 2014
> [    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7),
> cr=30c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> cache
> [    0.000000] Machine model: Texas Instruments Keystone 2 Edison EVM
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Switching to high address space at 0x800000000
> [    0.000000] WARNING: unsafe modification of in-place page tables -
> tainting kernel
> [    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
> [    0.000000] Forcing write-allocate cache policy for SMP
> [    0.000000] Memory policy: Data cache writealloc
>
> I am currently doing a git bisect to find the offending commit.
>
Does not look like few other TI A15 platforms are impacted by this.

branch: master e589c9e Merge branch 'x86-apic-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
defconfig: omap2plus_defconfig
gcc: arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
AM5728 (Dual A15):
 1:    BeagleBoard-X15(am57xx-evm): BOOT: PASS: http://slexy.org/raw/s21IM6bagp
DRA72x (Single A15):
 2:                     dra72x-evm: BOOT: PASS: http://slexy.org/raw/s212Gk53mv
DRA74x (Dual A15):
 3:                     dra7xx-evm: BOOT: PASS: http://slexy.org/raw/s21C5oTez8
OMAP5432 (Dual A15):
 4:                      omap5-evm: BOOT: PASS: http://slexy.org/raw/s20PMK1WGR
TOTAL = 4 boards, Booted Boards = 4, No Boot boards = 0


---
Regards,
Nishanth Menon
