From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 12:55:40 -0400
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <20150625161308.GF6844@leverpostej>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
Message-ID: <558C328C.5070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2015 12:13 PM, Mark Rutland wrote:
> On Thu, Jun 25, 2015 at 05:01:36PM +0100, Vitaly Andrianov wrote:
>>
>>
>> On 06/25/2015 10:59 AM, santosh shilimkar wrote:
>>> On 6/25/2015 7:45 AM, Mark Rutland wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jun 25, 2015 at 03:02:50PM +0100, Vitaly Andrianov wrote:
>>>>> This commit add cpu_die implementation using psci api
>>>>
>>>> I don't understand. If you have a PSCI implementation, it should be
>>>> sufficient to have a PSCI node (and enable-method) in your DT, and the
>>>> generic code will be used. Nothing should be required in your board
>>>> code.
>>>>
>>>> You should also use CPU_ON to bring secondaries online rather than
>>>> mixing up PSCI and platform-specific mechanisms.
>>>>
>>> Good point about CPU_ON. We need that as well.
>>>
>> Does it mean that keystone_defconfig must always have CONFIG_HOTPLUG_CPU
>> and CONFIG_ARM_PSCI enabled?
>
> No.
>
> You need CONFIG_ARM_PSCI for PSCI CPU_ON. Without CONFIG_HOTPLUG_CPU,
> you'll get PSCI CPU_ON but not PSCI CPU_OFF.
>
>> What is if someone doesn't want to have HOTPLUG_CPU?
>
> Then you don't get PSCI CPU_OFF, but can still have PSCI CPU_ON.
>
> Only the portions of the PSCI code required for turning CPUs off are
> dependent on HOTPLUG_CPU.
>
>> How he can boot secondary CPU w/o platform-specific mechanizm?
>
> By using PSCI CPU_ON.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Thanks Mark,

I need rework and re-test the patch.
One more question. Shall I post the dts related commit, which add PSCI 
command together with this commit? Or it may be posted later independently?

Thanks,
Vitaly
