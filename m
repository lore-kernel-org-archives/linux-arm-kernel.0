From: wni@nvidia.com (Wei Ni)
Date: Wed, 20 Feb 2013 18:27:29 +0800
Subject: [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
In-Reply-To: <5124429B.2000404@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-4-git-send-email-wni@nvidia.com>
 <512403F5.5010005@wwwdotorg.org> <5124429B.2000404@nvidia.com>
Message-ID: <5124A511.1060508@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 11:27 AM, Alex Courbot wrote:
> On 02/20/2013 08:00 AM, Stephen Warren wrote:
>> On 02/18/2013 04:30 AM, Wei Ni wrote:
>>> Add support to handle irq. When the temperature touch the limit value, the
>>> driver can handle the interrupt.
>>
>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>
>>> +static void lm90_irq_work(struct work_struct *work)
>> ...
>>> +	enable_irq(client->irq);
>>> +}
>>> +
>>> +static irqreturn_t lm90_irq(int irq, void *dev_id)
>>> +{
>>> +	struct lm90_data *data = dev_id;
>>> +
>>> +	disable_irq_nosync(irq);
>>
>> I think IRQF_ONESHOT would enable you to remove the manual
>> enable/disable_irq calls.
> 
> Oh, right. Using a threaded IRQ with IRQF_ONESHOT would make that happen 
> transparently. Wasn't aware of that, thanks.

Oh, yes, I will use it in my next version.

Thanks.
Wei.

> 
> Alex.
> 
> 
