From: private@roeck-us.net (Guenter Roeck)
Date: Thu, 24 Dec 2015 07:33:39 -0800
Subject: Running arm:versatile_defconfig with qemu in linux-next
In-Reply-To: <201512241058.30249.arnd@arndb.de>
References: <567B76E0.6050106@roeck-us.net> <201512241058.30249.arnd@arndb.de>
Message-ID: <567C1053.7010408@roeck-us.net>
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
I don't use any dtb files for the failing configurations. That wasn't
needed (and didn't work when I first set up my test system).

>> I can no longer get realview-eb-mpcore and realview-eb to work either,
>> but, again, that is with a qemu specific configuration.
> These are still based on board files, right? Do the normal defconfigs
> work?
I'll try to find working "normal" defconfigs. When I set up my test
system, I could not get any to work for realview-eb with qemu.

>> I tried to bisect, but there have been too many related changes in the code
>> for it to succeed; some of the bisect attempts don't even compile, others fail
>> due to different problems. Is it known if versatile_defconfig in linux-next runs
>> on a real system ? If so, any idea what it might take to get it to work again
>> with qemu ?
> Please start with the next/multiplatform branch in arm-soc, which has the
> conversion to devicetree. Let's first see if that works by itself. I would
> hope that all commits on that branch build, but something may have gone wrong.
Maybe I'll just need to start using devicetree files. I'll try that.

Thanks,
Guenter
