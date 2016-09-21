From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 21 Sep 2016 10:06:19 +0100
Subject: [PATCH 1/4] ARM: tegra: nyan: Use proper IRQ type definitions
In-Reply-To: <1474446366.1239.17.camel@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <ef69b6d2-ce6b-ff76-5c04-ab2176eb6ecc@nvidia.com>
 <1474395289.1215.20.camel@paulk.fr>
 <0ca614bf-4d27-9948-03e3-472d059f2153@nvidia.com>
 <1474446366.1239.17.camel@paulk.fr>
Message-ID: <eb7540c0-4abd-86c0-7777-78fe1f12bc59@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/09/16 09:26, Paul Kocialkowski wrote:
> * PGP Signed by an unknown key
> 
> Le mercredi 21 septembre 2016 ? 08:52 +0100, Jon Hunter a ?crit :
>> On 20/09/16 19:14, Paul Kocialkowski wrote:
>>>
>>>> Old Signed by an unknown key
>>>
>>> Le mardi 20 septembre 2016 ? 18:15 +0100, Jon Hunter a ?crit :
>>>>
>>>> On 28/08/16 18:32, Paul Kocialkowski wrote:
>>>>>
>>>>>
>>>>> This switches a few interrupt definitions that were using
>>>>> GPIO_ACTIVE_HIGH as IRQ type, which is invalid.
>>>>
>>>> May be you are right, but this does not describe why this is invalid.
>>>> Can you elaborate?
>>>
>>> GPIO_ACTIVE_HIGH is simply not the right kind of define to use in the
>>> "interrupts" devicetree property. Values provided there are understood as
>>> IRQ_TYPE_ defines.
>>
>> Right, but you are changing the type as GPIO_ACTIVE_HIGH = 0 and
>> IRQ_TYPE_EDGE_FALLING = 2 and there is no comment about why this has
>> been changed. It might be correct, but you need to explain it.
> 
> This actually makes the IRQ trigger values consistent with the drivers, that
> define them regardless of devicetree anyway. The max98090 driver
> has IRQF_TRIGGER_FALLING and bq24735 has IRQF_TRIGGER_RISING |
> IRQF_TRIGGER_FALLING.
> 
> This is really more of a cosmetic change, it doesn't impact actual use.

So you are saying that the drivers don't actually use the DT types? May
be that is ok, and yes this is cosmetic, but this should be stated in
the changelog as it is not clear what is going on here.

Cheers
Jon

-- 
nvpublic
