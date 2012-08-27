From: adrian.yanes@aalto.fi (Yanes Martinez Adrian)
Date: Mon, 27 Aug 2012 12:45:39 +0000
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <503B623C.4030304@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
Message-ID: <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Hi Adrian,

Le 08/27/2012 12:40 PM, Yanes Martinez Adrian a ?crit :
> Hi Ludovic,
>
>> Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>> eeprom, temperature sensor and rtc devices (and wolfson chip for
>> sam9g20).
>
> concerning the at91rm9200, what was the amount of bytes you transmitted?
>

> I have only checked that I can communicate with i2c devices so the
> amount is very low (1-4 bytes).

IIRC it was from >7 bytes when the issues appeared.

> Some months ago I performed some testing[1] with the previous version of
> the patch and the main conclusion was that the absence of PDC in the
> AT91RM9200 made this driver unusable in such platform.
>

> Does the new driver break something? Was it working with the old one?

The old driver never worked properly. GPIO I2C has been the only alternative
to use I2C over AT91RM9200. With the proposed driver I just encountered
the same issues mentioned in the previous thread (so at the end nothing
changed for the AT91RM9200, GPIO is the only way to go).

>There are some issues with which are not related to the driver but to
>the design of the IP. With old I2C versions, using GPIO I2C is recommended.

I think a warning should be included in the proposed driver for that reason.
Despite the driver will work in the mentioned SoCs, the users will encounter
issues in boards like AT91RM9200 and other legacy products.

Regards,

Adrian.
