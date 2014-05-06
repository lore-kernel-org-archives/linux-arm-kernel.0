From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 May 2014 00:11:38 +0800
Subject: [PATCH] irqchip: sirf: fix 'line over 80 characters'
In-Reply-To: <CAGsJ_4xYY-RkHQpek0i2BdcwFEn7NVK-Gt3jonf_yjHVgHRUZw@mail.gmail.com>
References: <1399388316-19465-1-git-send-email-21cnbao@gmail.com>
 <CAJgR-BikPVzi1bKpBwk-vvrDv9cwFgjWcg-NmH8SKsEOWDnxcg@mail.gmail.com>
 <CAGsJ_4xYY-RkHQpek0i2BdcwFEn7NVK-Gt3jonf_yjHVgHRUZw@mail.gmail.com>
Message-ID: <CAGsJ_4wibeWmE1-X_h+K5tkOKJ_wD+R88RqVvHynU2NUfq-C=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-07 0:07 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> 2014-05-06 23:23 GMT+08:00 Jon Loeliger <loeliger@gmail.com>:
>>> fix "line line over 80 characters" for the below:
>>> static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
>>>
>>> the users of the codes - key customers really care about that.
>>
>> And readers of the Linux logs - key developers really care about snark.
>>
>> jdl
>
> i have no choice since the key customer consist on that. i don't want
> the local codes lose sync with the mainline.
>

the key users insist on that, i failed to convince them. you know, the
user is the most important.

>>
>> On Tue, May 6, 2014 at 9:58 AM, Barry Song <21cnbao@gmail.com> wrote:
>>> From: Bin Shi <Bin.Shi@csr.com>
>>>
>>> fix "line line over 80 characters" for the below:
>>> static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
>>>
>>> the users of the codes - key customers really care about that.
>>>
>>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>  drivers/irqchip/irq-sirfsoc.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
>>> index 581eefe..5e54f6d 100644
>>> --- a/drivers/irqchip/irq-sirfsoc.c
>>> +++ b/drivers/irqchip/irq-sirfsoc.c
>>> @@ -58,7 +58,8 @@ static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
>>>         handle_IRQ(irqnr, regs);
>>>  }
>>>
>>> -static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
>>> +static int __init sirfsoc_irq_init(struct device_node *np,
>>> +       struct device_node *parent)
>>>  {
>>>         void __iomem *base = of_iomap(np, 0);
>>>         if (!base)
>>> --
>>> 1.7.5.4

-barry
