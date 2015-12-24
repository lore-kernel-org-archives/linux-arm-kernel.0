From: private@roeck-us.net (Guenter Roeck)
Date: Thu, 24 Dec 2015 11:51:34 -0800
Subject: Running arm:versatile_defconfig with qemu in linux-next
In-Reply-To: <201512241058.30249.arnd@arndb.de>
References: <567B76E0.6050106@roeck-us.net> <201512241058.30249.arnd@arndb.de>
Message-ID: <567C4CC6.40104@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 12/24/2015 01:58 AM, Arnd Bergmann wrote:
> On Thursday 24 December 2015, Guenter Roeck wrote:
>> Hi all,
>>
>> various versatile and realview configurations fail to run for me with
>> qemu (2.5) in linux-next. Some of those are qemu configurations
>> I collected from various sources, so I guess I am on my own there.
>> However, the following standard configurations no longer work.
>>
>> arm:versatileab:versatile_defconfig
>> arm:versatilepb:versatile_defconfig
> Just to be sure to rule out the obvious: are you using the dtb files from
> the kernel, or do you have your own?
I managed to get versatile_defconfig to work using the available dtb files
from the kernel, so this part is solved.

>> I can no longer get realview-eb-mpcore and realview-eb to work either,
>> but, again, that is with a qemu specific configuration.
> These are still based on board files, right? Do the normal defconfigs
> work?

I got the following combinations to work.

Configuration                    QEMU machine            QEMU CPU
realview-smp_defconfig    realview-eb-mpcore    default (arm11mpcore)
realview_defconfig            realview-eb                  cortex-a8 (default arm926 fails)
realview-defconfig            realview-pbx-a9           default (cortex-a9)

I can not get the available dtb files for realview (arm-realview-pb1176.dtb
and arm-realview-pb11mp.dtb) to work with anything I tried.
If you know a working configuration and qemu command line,
please let me know.

I don't find a working default configuration and qemu command line for the
realview-pb-a8 machine. For pb-a8 to work, I (still) need to unconfigure
all other machines.

>> I tried to bisect, but there have been too many related changes in the code
>> for it to succeed; some of the bisect attempts don't even compile, others fail
>> due to different problems. Is it known if versatile_defconfig in linux-next runs
>> on a real system ? If so, any idea what it might take to get it to work again
>> with qemu ?
> Please start with the next/multiplatform branch in arm-soc, which has the
> conversion to devicetree. Let's first see if that works by itself. I would
> hope that all commits on that branch build, but something may have gone wrong.
I think the mystery is resolved with the above results. My old configuration
for realview-pb-a8 no longer works because of configuration file changes,
and versatile now requires devicetree files.

Thanks a lot for the hint!

Guenter
