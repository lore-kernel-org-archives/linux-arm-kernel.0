From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 12 Dec 2012 12:26:37 +0100
Subject: [PATCH 4/4] devicetree: Add Renesas SH Mobile MSIOF spi
 controller binding doc
In-Reply-To: <CACxGe6s+1Debq2HoVKWPmZ-75JMGmeJ+qxdxqzVWpsKxoyUowQ@mail.gmail.com>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
 <1352288407-20594-5-git-send-email-hechtb@gmail.com>
 <20121206140849.280243E089D@localhost>
 <CACxGe6s+1Debq2HoVKWPmZ-75JMGmeJ+qxdxqzVWpsKxoyUowQ@mail.gmail.com>
Message-ID: <CABYn4swzDE30K6URR+cuWJsd5f0t5wrAsqc34LcnszX=jTo0Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

>>> +Renesas MSIOF spi controller
>>> +
>>> +Required properties:
>>> +- compatible :       "renesas,sh-msiof" for SuperH or
>>> +             "renesas,sh-mobile-msiof" for SH Mobile series
>>> +- reg : Offset and length of the register set for the device
>>> +- interrupts : interrupt line used by MSIOF
>>> +
>>> +Optional properties:
>>> +- chip_select  : Chip select, defaults to 0
>>
>> This doesn't make a lot of sense to me. What is this property for? Is
>> there more than one CS? And if there is, shouldn't the SPI driver be
>> able to manipulate more than one?
>
> Oh, wait, from reading the code, is this the number of chip select
> lines? If so, then there is a common property for this. This property
> should be named "num-cs".

Yes, this value is nowhere used in the driver but just forwarded to
the SPI subsystem as the number of chip selects.

>>
>>> +- tx_fifo_size : Overrides the default tx fifo size given in words
>>> +- rx_fifo_size : Overrides the default rx fifo size given in words
>>
>> Nit: property names should use '-' instead of '_' (by convention) and
>> custom properties should be prefixed with the manufacturer prefix to
>> avoid namespace collisions. ie. "renesas,tx-fifo-size.

Ok sure! Thanks for pointing it out.

I'll post v2 in a second.

Thanks,

 Bastian

>> g.
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
