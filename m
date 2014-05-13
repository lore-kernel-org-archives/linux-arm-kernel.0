From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 May 2014 11:58:08 -0500
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in the
 boot process
In-Reply-To: <20140513175404.319d067d@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
 <20140513163026.18a0fa61@free-electrons.com>
 <20140513153006.GC27822@titan.lakedaemon.net>
 <20140513175404.319d067d@free-electrons.com>
Message-ID: <CAL_JsqJhKy=whJE25me07YFxEMX+gCch42ZF_Z5_5xfsfAvFXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 10:54 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Jason Cooper,
>
> On Tue, 13 May 2014 11:30:06 -0400, Jason Cooper wrote:
>
>> > Well, I guess it's a per-maintainer choice:
>> >
>> > git log | grep "^Fixes:"
>> >
>> >     Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')
>>
>> Well, just because the maintainer is an idiot and didn't catch it isn't
>> an excuse to continue the behavior. ;-)

To be fair, documentation was added last week! I only noticed now
because I just found and read the documentation. In the future, I'll
probably forget and not notice thus becoming an idiot again. ;)

>
> Yes, no problem :)
>
>> >     Fixes: 54397d85349f ("ARM: kirkwood: Relocate PCIe device tree nodes")
>> >     Fixes: a7d4f81821f7 ('ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board')
>> >     Fixes: b484ff42df47 ('ARM: mvebu: Add support for NOR flash device on Armada XP-DB board')
>> >     Fixes: c971ff185f64 ("leds: leds-pwm: Defer led_pwm_set() if PWM can sleep")
>> >     Fixes: abccd00f8af2 ('btrfs: Fix 32/64-bit problem with BTRFS_SET_RECEIVED_SUBVOL ioctl')
>> >     Fixes: ee1e0994ab1bd (regulator: s5m8767: Use GPIO for controlling Buck9/eMMC)
>> >     Fixes: 652ed95d5fa6 (cpufreq: introduce cpufreq_generic_get() routine)
>> >
>> > Somewhat inconsistent :-)
>>
>> Yeah, I can go either way on the single quotes/double quotes.  The
>> 12-character hash definitely increases readability, though.
>
> I must say I never understood the logic here. We used to use 8 digit
> hashes, and then we had collisions. So it means that if we look at the
> Git history now, some of these 8 digit hashes no longer uniquely
> identify a commit.
>
> To fix this up, we moved to use 12 digit hashes. But that's just
> pushing the problem a bit further away, no? There will be some
> collision at some point, and therefore in the future 652ed95d5fa6 may
> no longer be a unique identifier for the "cpufreq: introduce
> cpufreq_generic_get() routine" commit, and therefore people reading the
> Git history 3 or 5 years from now will see non-unique identifiers in
> 'Fixes:' fields.

You could assume that the first match with "git log --online <commit
with fix> | grep <commit with bug>" is the offending commit and will
always work with only a few digits.

If it really becomes a frequent issue, we could add a git rev-parse
option to only look at ancestor commits to resolve hashes.

Rob
