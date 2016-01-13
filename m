From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 13 Jan 2016 02:07:37 +0000
Subject: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <5694BE36.7060702@atmel.com> (Nicolas Ferre's message of "Tue, 12
 Jan 2016 09:49:58 +0100")
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
 <5693C9A3.9040403@atmel.com> <yw1xh9ikw29c.fsf@unicorn.mansr.com>
 <5694BE36.7060702@atmel.com>
Message-ID: <yw1x37u2ut92.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Le 11/01/2016 16:43, M?ns Rullg?rd a ?crit :
>> Nicolas Ferre <nicolas.ferre@atmel.com> writes:
>> 
>>> Le 08/01/2016 01:11, Mans Rullgard a ?crit :
>>>> The driver currently chooses between internal chip-select or gpio
>>>> based on the existence of the cs-gpios DT property which fails on
>>>> non-DT systems and also enforces the same choice for all devices.
>>>
>>> Well, I fear that such a per-device choice may impact further the driver
>>> than just moving a field from one structure to another...
>> 
>> Could you please elaborate?
>
> Well, the first thing that comes to my mind is that the DT property may
> need to be  to the SPI device node and not the controller anymore, for a
> need of coherency.
> That would imply modifying the binding and I don't want that for such an
> useless "improvement".
>
>>> Moreover, I have the feeling that it was not the objective of this
>>> patch.
>> 
>> Your feeling is mistaken.  If it's somehow impossible to mix CS types,
>> please explain why.
>
> Please only fix the avr32 issue with CS gpio selection that I admit we
> have. I don't need nor want to mix CS types: it just doesn't make sense
> to allow it.

There's also this comment in spi.h regarding struct spi_master:

 * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
 *	number. Any individual value may be -ENOENT for CS lines that
 *	are not GPIOs (driven by the SPI controller itself).


-- 
M?ns Rullg?rd
