From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 3 Aug 2012 14:44:10 +0530
Subject: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
In-Reply-To: <50114069.7070605@mvista.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
 <1343219012-19472-2-git-send-email-anilkumar@ti.com>
 <500FE9FC.7070303@mvista.com> <501101A7.2030503@gmail.com>
 <50114069.7070605@mvista.com>
Message-ID: <501B9662.6000406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/26/2012 6:34 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-07-2012 12:36, Daniel Mack wrote:
> 
>>>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>>>> by adding d_can device node with all the necessary parameters.
> 
>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>> ---
>>>>    arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>>>    1 file changed, 5 insertions(+)
> 
>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>>> index 9b974dc..2db2ffb 100644
>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>> @@ -163,5 +163,10 @@
>>>>    			#size-cells = <0>;
>>>>    			ti,hwmods = "i2c3";
>>>>    		};
>>>> +
>>>> +		dcan1: d_can at 481D0000 {
>>>
>>>      Address postfix in the node name and no "reg" property?
> 
>> This still works due to the hwmod mappings OMAP relies on.
> 
>     I.e. the "reg" property is populated in runtime?
> 
>> I would still
>> put it there, so the switch to real DT definitions will be less painful.
> 
>     How it helps anything?
> 

This is required field if you want to use "of_dev_auxdata", without
"reg" property OF layer fails to create dev_id (name) bindings with what
you have specified as part of "of_dev_auxdata".

And with respect to CAN driver, even though we are using hwmod, I would
want to create dev_id = d_can.0 and d_can.1. And this is only possible
if Address and compatible string matches.

So this field is important and required in this case.

Thanks,
Vaibhav
