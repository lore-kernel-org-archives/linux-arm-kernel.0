From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 03 Aug 2015 12:00:27 -0700
Subject: [PATCH 1/2] ARM: dts: keystone: fix the clock node for mdio
In-Reply-To: <55BFB7EC.4060408@ti.com>
References: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
 <55BFB15B.8040207@ti.com> <55BFB32C.6080201@oracle.com>
 <55BFB7EC.4060408@ti.com>
Message-ID: <55BFBA4B.6070406@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/3/15 11:50 AM, Murali Karicheri wrote:
> On 08/03/2015 02:30 PM, santosh.shilimkar at oracle.com wrote:
>> On 8/3/15 11:22 AM, Murali Karicheri wrote:
>>> On 08/03/2015 02:11 PM, Murali Karicheri wrote:
>>>> Currently the MDIO clock is pointing to clkpa instead of clkcpgmac.
>>>> MDIO is part of the ethss and the clock should be clkcpgmac.
>>>>
>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>> ---
>>>>   arch/arm/boot/dts/keystone.dtsi | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/keystone.dtsi
>>>> b/arch/arm/boot/dts/keystone.dtsi
>>>> index e7a6f6d..6245a17 100644
>>>> --- a/arch/arm/boot/dts/keystone.dtsi
>>>> +++ b/arch/arm/boot/dts/keystone.dtsi
>>>> @@ -273,7 +273,7 @@
>>>>               #size-cells = <0>;
>>>>               reg        = <0x02090300 0x100>;
>>>>               status = "disabled";
>>>> -            clocks = <&clkpa>;
>>>> +            clocks = <&clkcpgmac>;
>>>>               clock-names = "fck";
>>>>               bus_freq    = <2500000>;
>>>>           };
>>>>
>>> Santosh,
>>>
>>> This is a big fix and needs to go in v4.2-rc. So please review and apply
>>> asap. v4.2 is the first release that has netcp driver fully functional
>>> and I want to fix as many known bugs as possible.
>>>
>> Do you have more fixes ? If yes, please post them so that I can include
>> them along with these two. I will try to send them up next week.
>
> I think we have got most of the know issues fixed in the netcp driver
> and dts for v4.2-rc. Another lingering issue is the one with multiple
> clock handling not supported in run time pm API causing us to use the
> work around 'clk_ignore_unused'. Probably this needs to be addressed in
> the future as fixing this is not trivial. Generic PD support would
> partially solve the issue for Keystone, but also needs to handle
> multiple clocks for keystone.
>
Yeah. I was also wondering on what happened to that work which was
active at some point of time.

> Another option is to  fix the NetCP and QMSS/KNAV driver for now in
> v4.0-rc using explicit clock APIs so that we don't have to use
> 'clk_ignore_unused'. And then migrate all of the drivers to run time PM
> API later when proper framework is implemented along with K2G support.
> Does this make sense?
>
Multiple clock node support work which was started needs to be revived.
Direct clock isn't the way to go about it.

> Anyways, please submit these patches at your earliest opportunity.
>
Sure.

Regards,
Santosh
