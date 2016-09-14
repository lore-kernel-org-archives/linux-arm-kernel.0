From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 14 Sep 2016 15:44:12 +0200
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <alpine.DEB.2.20.1609141532510.6233@nanos>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609131713490.6233@nanos>
 <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
 <alpine.DEB.2.20.1609141103420.6233@nanos>
 <facd1c7c-d696-eae1-02e4-5a0c9285add0@st.com>
 <alpine.DEB.2.20.1609141532510.6233@nanos>
Message-ID: <f64e4f9d-d811-2c6e-7c5a-d4ab06716e2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2016 03:34 PM, Thomas Gleixner wrote:
> On Wed, 14 Sep 2016, Alexandre Torgue wrote:
>> On 09/14/2016 11:19 AM, Thomas Gleixner wrote:
>>>
>>> Now what really bugs me is that you do that at all. An interrupt which is
>>> freed must be masked already. Why is it unmasked in the first place?
>>
>> Honestly I don't know. When "devm_free_irq" is called to release virq, there
>> is no issue and interrupt is well masked. But, when I tried to use
>> "irq_dispose_mapping(virq)" I observed that .free is called (child and parent
>> domain) but interrupt is not masked.
>
> Well, you just used some function in some context which is not relevant to
> the normal operation. So adding that mask() is just paranoia for no value.

I agree. I just wanted to "force" a test for .free callback. If it not 
relevant I'll remove ".free" callback of exti domain.
As a part of this series has already been taken by Linus (pinctrl part), 
I will send a new series only for irqchip part (patches [1] and [2]). Do 
you agree ?

Thanks
Alex


>
> Thanks,
>
> 	tglx
>
