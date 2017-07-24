From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Jul 2017 14:49:22 -0700
Subject: [PATCH 2/2] net: ethernet: nb8800: Fix RGMII TX clock delay setup
In-Reply-To: <54ca7197-780a-68b1-0cf2-88ccc7ce4201@free.fr>
References: <b332dc3e-4478-e34b-2b3f-226aad8a11d4@sigmadesigns.com>
 <61b71d12-4e3a-edbe-1d69-c66e7cf46d8e@sigmadesigns.com>
 <yw1xzic0qrcg.fsf@mansr.com> <001a7afd-364d-359e-1478-e057c9083f73@free.fr>
 <d8121f82-dffd-22c7-1209-a3c2329703e5@gmail.com>
 <05cbc32e-a4af-1c81-128b-bc5d2206d24a@free.fr>
 <bf484952-15ae-b385-6b54-4d07b3bc2b29@gmail.com>
 <54f5bd21-766d-d9de-3b15-a01fd5ee6035@free.fr>
 <54ca7197-780a-68b1-0cf2-88ccc7ce4201@free.fr>
Message-ID: <5c48496e-8c67-5af5-e0c5-7b0c298adc84@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2017 02:21 PM, Mason wrote:
> On 20/07/2017 14:33, Mason wrote:
> 
>> As [Florian] pointed out, the spec states that the
>> "Data to Clock input Skew (at Receiver)"
>> must be within [ 1.0, 2.6 ] ns.
>>
>> I understand that 2 ns is 1/4 of a 125 MHz period,
>> but it's not clear to me why the above interval is
>> centered at 1.8 instead of 2.0 ns.
>>
>> Also, the AR8035 PHY offers 4 possible TX clock delays:
>> { 0.25, 1.3, 2.4, 3.4 } according to their doc.
>> The two extremes are outside the interval, when would
>> they be useful? In case the transmitter adds "bad" skew?
>>
>> Why doesn't the PHY support 1.8/2.0? Is it perhaps
>> unable to, because of PLL limitations?
> 
> I haven't yet found answers for these questions.
> 
> - Why is the interval centered at 1.8 instead of 2.0 ns?

Presumably because this is almost the middle of the available range and
it still provides a value that is within the specification...

> - What use are 0.25 ns and 3.4 ns skew?

Accounting for extreme PCB traces lengths possibly, or just exposing the
raw values that the HW supports by increments of 0.25 ns, just because
the HW supports it.

> - Why doesn't the PHY support a "recommended" value like 1.8 ns?
> 
> Does anyone have pointers to good resources?

The PHY datasheet and the RGMII specification really ought to be the
starting points, there is not much more to it. Maybe go ask your support
person at Qualcomm/Atheros about their PHY design?
-- 
Florian
