From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Jun 2016 22:29:17 +0300
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <20160610010245.GA10152@verge.net.au>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
 <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
 <CAMuHMdUkOpEp+YCbZVZppdN4C7KKpDS9_gEuXi_WKZXM9YHgEQ@mail.gmail.com>
 <ab5e3a98-7ff2-dc8f-d255-f6da26f43527@cogentembedded.com>
 <20160610010245.GA10152@verge.net.au>
Message-ID: <8efb1c7e-5463-2556-744c-d327886d92d4@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 04:02 AM, Simon Horman wrote:

>> [...]
>>
>>>>> And that the system behaves sanely on suspend/resume.
>>>>
>>>>   I'd be thankful if you told me how to test that. :-)
>>>
>>> System suspend:
>>>
>>>    echo mem > /sys/power/state
>>
>>    Oh. I know that one! :-)
>>
>>> System resume: You're gonna need a "wakeup-source" in your DTS, e.g. gpio-keys.
>>> Serial should work too, echo "enabled" to the corresponding wakeup
>>> file in /sys first.
>>
>>    I'm afraid I couldn't find that file. All I saw were RPM controls...
>>
>>> In case of issues, try "echo 0 > /sys/module/printk/parameters/console_suspend".
>>
>>    There's no problems suspending, it's the resuming that's a problem for me.
>>
>>> Good luck!
>>
>>    As usual, there was no luck. :-)
>>
>> WBR, Sergei
>
> Does resume work for UP (i.e. without SMP)?

    No. My problem with resume is I can't wake up the remote system. I don't 
see the needed 'wakeup' file in /sys/devices/platform/soc/e6e60000.serial/...
     However, if I enable CONFIG_PM_[ADVANCED_]DEBUG and do

$ echo -n core /sys/.power/pm_test

the system happily wakes up after a small delay (5 s), w/either SMP or UP kernel.

> How did testing CPU hotplug go? Did it work for all CPUs?

    Sure!
    The only problem I'm seeing (again) is the RCAN clock failing to register:

rcar_gen2_cpg_clocks_init: failed to register cpg_clocks rcan clock (-12)

    I was going to look at it yesterday but (wrongly) thought it somehow cured 
itself... I'll look at it now.

MBR, Sergei
