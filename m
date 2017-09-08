From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 9 Sep 2017 00:06:48 +0900
Subject: [PATCH v4 0/6] irqdomain, gpio: expand irq_domain_push_irq() for
 DT use and use it for GPIO
In-Reply-To: <b0f7495b-3b51-a75f-2a29-bbcd86eacb53@arm.com>
References: <1504784522-26841-1-git-send-email-yamada.masahiro@socionext.com>
 <b0f7495b-3b51-a75f-2a29-bbcd86eacb53@arm.com>
Message-ID: <CAK7LNASFPdcgifCChbeXPzek3Lk_x-q7LG83vv8LK0jWkurE5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc.

2017-09-07 21:39 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
>> I think there is a possibility where a device tries to get IRQ
>> after irq_domain_create_hierarchy(), but before irq_domain_push_irq().
>>
>>       priv->domain = irq_domain_create_hierarchy(...)
>>       if (!priv->domain)
>>               return -ENOMEM;
>>
>>         [  *** What if a irq consumer device request the irq here? *** ]
>
> We've explicitly forbidden such a use case. There is a (not exactly fool
> proof) check in irq_domain_push_irq(), but it is pretty easy to bypass
> it. "Don't do it" is the conclusion we reached with David Daney.
>
> If you don't want these interrupts to be requested, you might as well
> flag them as IRQ_NOREQUEST, and unflag them when the hierarchy is ready.
>
> Would that work for you?


Sorry if my description was unclear.

I do not think IRQ_NOREQUEST is equivalent
to IRQ_DOMAIN_FLAG_NO_CREATE I am trying to add in 5/6.


My intention is to prevent platform_get_irq()
from allocating a new virq.

I think IRQ_NOREQUEST only affects request_irq().



Having said that, this series got negative response
as a whole.

My motivation is to get my GPIO driver (6/6) in
by hook or by crook.
If you do not like this series, please feel free to throw it away.




-- 
Best Regards
Masahiro Yamada
