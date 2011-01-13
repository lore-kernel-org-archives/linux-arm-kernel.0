From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 13 Jan 2011 12:12:16 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <20110113091355.GP24920@pengutronix.de>
References: <20110113091355.GP24920@pengutronix.de>
Message-ID: <4D2EDE10.3040809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2011 10:13, Uwe Kleine-K?nig :
> <jason77.wang@gmail.com>
> Bcc: 
> Subject: Re: i.MX & IRQF_ONESHOT
> Reply-To: 
> In-Reply-To: <4D2EB6EF.7030608@eukrea.com>
> 
> Hello,
> 
> [adding tglx who AFAIK invented threaded irqs and the people involved
> in 2991a1ca6e9b to Cc]
> 
> On Thu, Jan 13, 2011 at 09:25:19AM +0100, Eric B?nard wrote:
>> while testing 2.6.37 on our i.MX27 based board - code in
>> arch/arm/mach-imx/eukrea_mbimx27-baseboard.c - I noticed the
>> touchscreen controller (ADS7846) doesn't work anymore.
>>
>> A few IRQ are generated when probing for the chipset and starting
>> calibration (usually first point works), then nothing more (even if
>> the IRQ signals is generated as seen on the scope, the irq count
>> doesn't increase anymore and stays <= 4 and no data is reported to
>> the input layer).
>>
>> drivers/input/touchscreen/ads7846.c was switched to threaded IRQ in
>> commit 2991a1ca6e9b13b639a82c0eec0cbc191bf1f42f where was added :
>> irq_flags |= IRQF_ONESHOT;
> AFAIK this is how threaded irq usually work.  The irq should get
> reenabled by irq_thread -> irq_finalize_oneshot then.
> 
>> Commenting out this line in the ads7846 driver makes it work again.
>> Am I missing something obvious or is there a reason for IRQF_ONESHOT
>> creating trouble with gpio irq or SPI on i.MX ?
> I don't know.  Is the irq masked?  pending?

Just to let you know that I have the same issue on my at91sam9g10ek:
atmel_spi + ads7846 (using ADS7843e actually).
... solved by same workaround.

Best regards,
-- 
Nicolas Ferre
