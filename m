From: hunold@linuxtv.org (Michael Hunold)
Date: Mon, 12 Mar 2012 11:40:15 +0100
Subject: iMX53 and MMC_CAP_SDIO_IRQ
In-Reply-To: <20120312101037.GA2459@pengutronix.de>
References: <4F5DB793.3080904@linuxtv.org>
 <20120312101037.GA2459@pengutronix.de>
Message-ID: <4F5DD28F.50600@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

thank you for your answer.

on 12.03.2012 11:10 Wolfram Sang said the following:
>> Probably this is a question for the Freescale people: why was the
>> "mx_sdhci" necessary at all
> 
> It probably was never necessary, it was just easier to hack on a forked
> driver, because you can't break other sdhci-users, I guess. Since large
> portions of the code are duplicated but issues have been fixed in a
> very, ahem, custom manner, this was never suitable for mainline. Back
> then, most vendors thought this is good enough. Luckily, times have
> changed a bit.

Yes, I know that thinking.

>> and why is it not necessary any more?
> 
> Because I wanted SD support in mainline, so I had to take a different
> path.

I understand.

>> Any help, hints and historical informations are highly appreciated,
>> before I start to look deeper into this problem.
> 
> They don't have a common ancestor. Just dig into both, you will
> recognize patterns, I guess.

Ok, to sum this up:

SDIO IRQs are working in mx_sdhci in the Freescale tree because it was
properly implemented and tested, obviously.

SDIO IRQs are working for sdhci in mainline probably for other
non-freescale platforms.

You fixed the generic sdhci driver in mainline to work with iMX53 to get
rid of the need for mx_sdhci, but probably never got the chance to test
if SDIO IRQs are really working.

That means, the subtle difference between mx_sdhci and sdhci to get SDIO
IRQS to work on sdhci with iMX53 has yet to be found.

> Regards,
>    Wolfram

CU
Michael.
