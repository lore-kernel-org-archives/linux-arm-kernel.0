From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 02 Jul 2015 17:54:29 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <20150702152147.GA10111@localhost.localdomain>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <5594E9F6.7040701@linutronix.de>
 <20150702142601.GB9349@localhost.localdomain>
 <55954B17.3020303@linutronix.de>
 <20150702152147.GA10111@localhost.localdomain>
Message-ID: <55955EB5.4090400@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 05:21 PM, Richard Cochran wrote:
> On Thu, Jul 02, 2015 at 04:30:47PM +0200, Sebastian Andrzej Siewior wrote:
>> On 07/02/2015 04:26 PM, Richard Cochran wrote:
>>> On Thu, Jul 02, 2015 at 09:36:22AM +0200, Sebastian Andrzej Siewior wrote:
>>>> If you are in a specific SoC you could do
>>>> 	base = of_alias_get_id(np, "gpio") * num_of_gpio_per_chip
>>>> and get consistent numbers / sane.
>>>
>>> And what about /sys/class/gpio ?
>>
>> What about it?
> 
> The poor users of that interface cannot use "of_alias_get_id" as you suggest.

You do that in the driver. The only problem with that is that the
synopsys controller can have between one and four banks and a bank can
have 1-32 GPIOs if I remember correctly. That means you can't have a
static number of GPIOs like others do.
Therefore I think a starting property is the only way and I would
prefer a generic one.

What confuses me a little: Why is there a snps,nr-gpios property?
Doesn't the snps' IP-Core expose this information?

> Thanks,
> Richard
> 
Sebastian
