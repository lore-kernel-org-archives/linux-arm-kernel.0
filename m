From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Feb 2015 23:14:13 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <20150216162712.GR14545@x1> (Lee Jones's message of "Mon, 16 Feb
 2015 16:27:12 +0000")
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <20150216162712.GR14545@x1>
Message-ID: <87fva5a4i2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> What's all this?  Please configure your mail client correctly.
>
> For advice, see:
>
>   Documentation/email-clients.txt
While at day work, I have only access to web mail ...

>>  2) after v2, we _both_ agreed that the accurate name is "cplds"
>>     which exactly what is in this patch
>>     (see device registering with lubbock_cplds).
>
> There is no mention of this decision in the changelogs.  If it's not
> in the change logs, it didn't happen. ;)
Ah right.

> I'm still concerned with the fact that the driver file is named using
> and is populated by lots of instances of a "board" name.  I'm sure you
> would share my thoughts is someone submitted a driver called
> beaglebone.c or raspberrypi.c to MFD.
I understand your concern. Arnd, a thought about it ? The only viable
alternative would be to move it to arch/arm/plat-pxa AFAIS.

>> > Besides, this is MFD, where we support single pieces of silicon which
>> > happen to support multiple devices.  I definitely don't want to support
>> > boards here.
>> > You might want to re-think the naming and your (sales) pitch.
>> I might need help. As for the (sales), no comment.
>
> By pitch, I mean to convince me that this belongs in MFD.
I've been trying.

>> I thought cplds were to be handled by an MFD driver.
>
> Not to my knowledge, although we do appear to have one.  That doesn't
> necessarily mean that it's the right place for it though.  I'm not
> entirely sure how CPLDs even work on a functional level.
As I said, I understand your concern.

>> > I'm going to stop here, as I think I need more of an explanation so
>> > what you're trying to achieve with this driver.
>> Why ? I think things were clear that this driver handles the CPLDs on
>> lubbock board, namely u46 and u52. I don't understand what is wrong
>> with this patch so that you don't want to go forward.
>
> Understanding was lost when I learned that the whole file was centred
> around the premise of board support.  I understand now that this is a
> driver for a CPLD, which I'm not sure is even MFD.  Also, if it is
> really a CPLD driver, shouldn't be named after the manufacturer/model
> number of the chip, rather than the PCB which it's connected to?
>
> I'm also concerned that this driver has no functional CPLD code
> contained.  All you're doing is defining an IRQ domain.  Why then
> isn't this really an drivers/irqchip (Suggested-by: Josh Cartwright)
> driver?
Is not only a irqchip because, as explained at the bottom of the commit message,
quoting myself :
  This patch moves all that handling to a mfd driver. It's only purpose
  for the time being is the interrupt handling, but in the future it
  should encompass all the motherboard CPLDs handling :
   - leds
   - switches
   - hexleds

When these parts will be added, and they'll have to be handled by this driver
because of iospace sharing, and same IP (cplds) providing the hardware support,
the irqchip way will be just impossible to follow.

As I said above, I understand your concern. If we all reach a concensus this
should be moved to the pxa tree, so be it. But I'd like other opinion here.

Cheers.

-- 
Robert
