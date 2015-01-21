From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 21 Jan 2015 09:27:54 +0100
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
In-Reply-To: <20150121081645.GC9258@x1> (Lee Jones's message of "Wed, 21 Jan
 2015 08:16:45 +0000")
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1>
 <20150120115658.GJ26493@n2100.arm.linux.org.uk>
 <873874fuei.fsf@free.fr> <20150121081645.GC9258@x1>
Message-ID: <87y4owedx1.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> On Wed, 21 Jan 2015, Robert Jarzmik wrote:
>> > > > platform_get_irq()?
>> > > No. I need the flags.
>> > Where are they used?
>> A couple of lines below, using local "irqflags" variable :
>>        ret = devm_request_irq(&pdev->dev, cot->irq, lubbock_irq_handler,
>>                               irqflags, dev_name(&pdev->dev), cot);
>
> No, I mean where are they _used_?
I don't get your point.

For you, isn't it "using" irqflags by passing them as an argument to devm_request_irq()
??? And if you think ahead, then there are used all around in
kernel/irq/manage.c, as you probably know.

Cheers.

-- 
Robert
