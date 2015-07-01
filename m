From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 1 Jul 2015 08:03:05 -0700
Subject: [PATCH] keystone: dts: add psci command definition
In-Reply-To: <5593E59B.9090304@ti.com>
References: <1435752784-30639-1-git-send-email-vitalya@ti.com>
 <1435752784-30639-2-git-send-email-vitalya@ti.com>
 <20150701124101.GB2310@leverpostej> <5593E59B.9090304@ti.com>
Message-ID: <55940129.7020504@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/1/2015 6:05 AM, Vitaly Andrianov wrote:
>
>
> On 07/01/2015 08:41 AM, Mark Rutland wrote:
>> On Wed, Jul 01, 2015 at 01:13:04PM +0100, Vitaly Andrianov wrote:
>>> This commit adds definition for cpu_on, cpu_off and cpu_suspend
>>> commands.
>>> These definitions must match the corresponding PSCI definitions in
>>> boot monitor.
>>>
>>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>>> ---
>>>   arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/keystone.dtsi
>>> b/arch/arm/boot/dts/keystone.dtsi
>>> index c06542b..ab60fca 100644
>>> --- a/arch/arm/boot/dts/keystone.dtsi
>>> +++ b/arch/arm/boot/dts/keystone.dtsi
>>> @@ -58,6 +58,14 @@
>>>                    <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
>>>       };
>>>
>>> +    psci {
>>> +        compatible    = "arm,psci";
>>> +        method        = "smc";
>>> +        cpu_suspend    = <0x84000001>;
>>> +        cpu_off        = <0x84000002>;
>>> +        cpu_on        = <0x84000003>;
>>> +    };
>>
>> It would be nice to have this injected automatically by the bootlaoder
>> when PSCI is present, as that way users of existing systems can upgrade
>> their DTB and still have things boot.
>>
>> Thanks,
>> Mark.
>>
>
> So, KS2 kernel doesn't need that commit and has to wait this from
> u-boot? Actually PSCI support is a part of KS2 boot-monitor. U-boot is
> just responsible to load and start it, but doesn't know whether PSCI is
> supported.
>
> In any case you are right. The DTS also doesn't know whether boot-
> monitor supports PSCI. It is better to make u-boot to fix up the dts.
> Let's forget about this patch. I'll work on dts fix-up in u-boot.
>
Good. We can't break existing users as already pointed out earlier.
Thanks Vitaly for following it up.

Regards,
Santosh
