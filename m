From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 24 Mar 2011 22:41:42 +0800
Subject: [patch v4 1/3] arm: introduce cross trigger interface helpers
In-Reply-To: <20110308163113.GB9995@trinity.fluff.org>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-2-git-send-email-tom.leiming@gmail.com>
	<20110308163113.GB9995@trinity.fluff.org>
Message-ID: <AANLkTi=-Y+GQ==F01tq+exxRCPowiy9EWFNaUYWwCX-c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

2011/3/9 Ben Dooks <ben-linux@fluff.org>:

> could you just use the primecell register information for these

Seems there is no the primecell register information for these.

Follows some comment from Will in private mail:

Other primecell drivers in the kernel (sp810, pl330, nomadik MTU, ...)
define these themselves so I don't see the problem. Furthermore,
the actual ID registers are often incorrect in the hardware, but
we don't appear to be using them anyway.


>> +static inline void cti_irq_ack(struct cti *cti)
>> +{
>> + ? ? void __iomem *base = cti->base;
>> + ? ? unsigned long val;
>> +
>> + ? ? val = __raw_readl(base + CTIINTACK);
>> + ? ? val |= BIT(cti->trig_out_for_irq);
>
> would it be easier to get a pre-shifted bit here?

I don't think the above is more difficult, do I?

thanks,
-- 
Lei Ming
