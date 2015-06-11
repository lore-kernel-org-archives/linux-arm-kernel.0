From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 11 Jun 2015 08:33:54 -0600
Subject: [PATCH RFC 2/3] PM / Domains: Support atomic PM domains
In-Reply-To: <5578D293.9050809@samsung.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-3-git-send-email-lina.iyer@linaro.org>
 <55740D00.1030203@samsung.com> <20150610161323.GA4497@linaro.org>
 <5578D293.9050809@samsung.com>
Message-ID: <20150611143354.GA1103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11 2015 at 18:13 -0600, Krzysztof Kozlowski wrote:
>On 11.06.2015 01:13, Lina Iyer wrote:
>> On Sun, Jun 07 2015 at 03:21 -0600, Krzysztof Kozlowski wrote:
>>> W dniu 05.06.2015 o 07:29, Lina Iyer pisze:

...

>>>> @@ -1266,11 +1338,18 @@ int __pm_genpd_add_device(struct
>>>> generic_pm_domain *genpd, struct device *dev,
>>>>      if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>>>>          return -EINVAL;
>>>>
>>>> +    /* Devices in an IRQ safe PM Domain have to be irq safe too */
>>>
>>> Why? Can you add this information here? Previously there was a reason in
>>> case of irq_safe devices which you removed leaving only policy.
>>>
>> Sorry, your question is not clear to me.
>> I believe this is a new requirement that enforces the contained devices
>> of an irq-safe domain to be irq-safe as well.
>
>What I wanted to say is that it would be nice if comment explained why
>domain have to be IRQ safe too. Without this "WHY" answer the comment is
>quite redundant - the "if" statement is obvious. But the "WHY" is not
>such obvious.
>
>Previous comments in few places mentioned the answer:
>/*
> * We can't allow to power off the PM domain if it holds an irq_safe
> * device. That's beacuse we use mutexes to protect data while power
> * off and on the PM domain, thus we can't execute in atomic context.
> */
>
Oh, yes. Will fix it.

Thanks,
Lina
