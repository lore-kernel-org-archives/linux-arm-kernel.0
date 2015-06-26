From: vitalya@ti.com (Vitaly Andrianov)
Date: Fri, 26 Jun 2015 12:57:54 -0400
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <558C4B84.9030303@oracle.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
 <558C328C.5070803@ti.com> <20150625165741.GA10564@leverpostej>
 <20150625172057.GA11952@leverpostej> <558C4B84.9030303@oracle.com>
Message-ID: <558D8492.2090503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2015 02:42 PM, santosh shilimkar wrote:
> On 6/25/2015 10:20 AM, Mark Rutland wrote:
>>>> I need rework and re-test the patch.
>>>> One more question. Shall I post the dts related commit, which add PSCI
>>>> command together with this commit? Or it may be posted later
>>>> independently?
>>>
>>> The DTS and Kconfig changes can be seaprate patches, but they'll need to
>>> go through at the same time.
>>
>> If your bootloader patches the DTB then you don't even need a dts
>> update. That should make things less confusing for existing users...
>>
> More than confusing we need to keep existing DTB binding work with
> updated kernel at least for as basic as booting all the CPUs.
>
> Regards,
> Santosh
>
>
OK. Now I'm confused :) We may have several different configurations here:

1) CONFIG_HOTPLUG_CPU and CONFIG_ARM_PSCI are not set.
    In this case keystone arch needs to have
    keystone_smp_boot_secondary();

2) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI is not set.
    keystone_smp_boot_secondary() is required and non PSCI
    implementation of keystone_cpu_die() is also required.

3) CONFIG_HOTPLUG_CPU is not set and CONFIG_ARM_PSCI=y
4) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI=y

    How do I boot secondary CPUs in cases of 3 and 4?
    Do I need to implement PSCI version of the
    keystone_smp_boot_secondary() of adding PSCI commands to DTB is
    enough?

    Do I need to implement keystone_cpu_die() if PSCI commands are
    added to DTB?

Thanks,
Vitaly 	
