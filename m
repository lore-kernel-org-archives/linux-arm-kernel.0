From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 21 Jan 2015 08:46:29 +0100
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1>
 <20150120115658.GJ26493@n2100.arm.linux.org.uk>
Message-ID: <873874fuei.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> What I'd suggest (and always have done) is:
>
> 	dev_err(&pdev->dev, "couldn't request main irq%d: %d\n",
> 		irq, ret);
I like it, it's even more compact, I'll use it for next patch version.

> but I guess printing the IRQ number no longer makes sense with todays
> dynamic mapping of logical IRQ numbers, as it is no longer meaningful.
Yes ... we're not yet there with pxa gpio interrupts, maybe it will come
eventually one day.

For Lee:
> > > platform_get_irq()?
> > No. I need the flags.
> Where are they used?
A couple of lines below, using local "irqflags" variable :
       ret = devm_request_irq(&pdev->dev, cot->irq, lubbock_irq_handler,
                              irqflags, dev_name(&pdev->dev), cot);

Cheers.

-- 
Robert
