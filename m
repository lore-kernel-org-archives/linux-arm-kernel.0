From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 12:10:45 +0100
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
In-Reply-To: <5AA1F30B.8010607@samsung.com>
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
 <20180307171111.14551-1-s.nawrocki@samsung.com>
 <5AA0B59F.3070402@samsung.com>
 <3c68c3da-a0c3-4e4e-da6b-3e4b1af6d19d@samsung.com>
 <5AA0DD39.3040108@samsung.com>
 <9f1e8619-974d-cd07-79c3-c6d9a4dc0f97@samsung.com>
 <5AA0F10D.9010602@samsung.com>
 <e3e1c628-d88f-6fb4-171e-a49c7ee38135@samsung.com>
 <5AA1F30B.8010607@samsung.com>
Message-ID: <6e9a0ba4-2997-b7c5-f5c3-461870b7d3e5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2018 03:35 AM, Inki Dae wrote:
> 2018? 03? 08? 20:22? Sylwester Nawrocki ?(?) ? ?:
>> On 03/08/2018 09:15 AM, Inki Dae wrote:
[...]
>>> Is there a possibility for other boards based on Exynos4210/4212/5420/5433 
>>> SoC to use this property later?
>>
>> All these SoCs have the HDMI IP block which has one input DAI, connected 
>> internally over I2S bus with the I2S controller.
>>
>> I think there is no advantage in limiting ourselves now only to SoC's 
>> for which we currently rely on that DT property in current kernel code, 
>> just to update this documentation later when we actually put the property 
>> in dts files.
>>
>> In case of exynos5420 we already require #sound-dai-cells for Odroid and
> 
> Maybe exynos5422? Odroid XU3/4 use Exynos5422.

Yes, my mistake, Exynos5422 for Odroid and Exynos5420 for Peach-Pit.
It just happens we use "samsung,exynos5420-hdmi" compatible for that both
SoCs.
 

> Seems that '#sound-dai-cells' is required mandatorily in case of Exynos5422 
> because Odroid XU3/4 Audio driver checks this property, and the driver 
> returns error if the property doesn't exist in its device tree.
> And if other SoCs - Exynos4210/4212/5250/5420/5433 - require this property 
> with additional driver works later then this property would also be required 
> mandatorily for them not optionally. In this case we may need to modify the 
> description again.
> 
> So my opinion is to add only the description required mandatorily if I 
> understood correctly.

You are right, it would be better to make this a mandatory property, I only
made it optional because now this property is missing in many dts files.
Let me resend with #sound-dai-cells description moved to the "Required 
properties" paragraph.

--
Thanks,
Sylwester
