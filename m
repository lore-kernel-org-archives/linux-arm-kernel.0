From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 16:51:25 +0300
Subject: [Patch] ARM: dts: keystone: add pll controller syscon entry
In-Reply-To: <537CEEFA.8080805@cogentembedded.com>
References: <1400681875-24432-1-git-send-email-ivan.khoronzhuk@ti.com>
 <537CEE13.5040908@cogentembedded.com> <537CEEFA.8080805@cogentembedded.com>
Message-ID: <537E00DD.4060702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/21/2014 09:22 PM, Sergei Shtylyov wrote:
> On 05/21/2014 10:18 PM, Sergei Shtylyov wrote:
>
>>> The pll controller register set includes sets of registers with
>>> different purposes, so it's logically to add syscon entry to be able
>>> to access them from appropriate places.
>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>
>>> Based on linux-next/master
>
>>>   arch/arm/boot/dts/keystone.dtsi | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>
>>> diff --git a/arch/arm/boot/dts/keystone.dtsi 
>>> b/arch/arm/boot/dts/keystone.dtsi
>>> index d9f99e7..5e67c5b 100644
>>> --- a/arch/arm/boot/dts/keystone.dtsi
>>> +++ b/arch/arm/boot/dts/keystone.dtsi
>>> @@ -66,6 +66,11 @@
>>>           ranges = <0x0 0x0 0x0 0xc0000000>;
>>>           dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
>>>
>>> +        pllctrl: pll_controller {
>
>>    I think it's better to follow the pattern established by 
>> "reset-controller"
>> and use hyphen ISO dash in the node name. This is also a common 
>> practice to
>
>    Oops, hyphen and dash are basically the same thing; I meant 
> s/dash/underscore/.

You meant s/underscore/dash.
I'll replace.
FYI: the change is included in new series [Patch v5 0/7] Introduce 
keystone reset driver

And this patch is squashed in:
[Patch v5 6/7] ARM: dts: keystone: update reset node to work with reset 
driver

Thanks.

>
>> use hyphens in the device trees overall.
>
>>> +            compatible = "ti,keystone-pllctrl", "syscon";
>>> +            reg = <0x2310000 0x200>;
>>> +        };
>>> +
>>>           rstctrl: reset-controller {
>>>               compatible = "ti,keystone-reset";
>>>               reg = <0x023100e8 4>;    /* pll reset control reg */
>>>
>
> WBR, Sergei
>

-- 
Regards,
Ivan Khoronzhuk
