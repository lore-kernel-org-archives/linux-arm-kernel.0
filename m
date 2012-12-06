From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 6 Dec 2012 14:13:23 +0000
Subject: [PATCH 4/4] devicetree: Add Renesas SH Mobile MSIOF spi
 controller binding doc
In-Reply-To: <20121206140849.280243E089D@localhost>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
 <1352288407-20594-5-git-send-email-hechtb@gmail.com>
 <20121206140849.280243E089D@localhost>
Message-ID: <CACxGe6s+1Debq2HoVKWPmZ-75JMGmeJ+qxdxqzVWpsKxoyUowQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 2:08 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed,  7 Nov 2012 12:40:07 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
>> Add binding documentation for Renesas' MSIOF SPI controller.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/spi/sh-msiof.txt |   12 ++++++++++++
>>  1 files changed, 12 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> new file mode 100644
>> index 0000000..b62312e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
>> @@ -0,0 +1,12 @@
>> +Renesas MSIOF spi controller
>> +
>> +Required properties:
>> +- compatible :       "renesas,sh-msiof" for SuperH or
>> +             "renesas,sh-mobile-msiof" for SH Mobile series
>> +- reg : Offset and length of the register set for the device
>> +- interrupts : interrupt line used by MSIOF
>> +
>> +Optional properties:
>> +- chip_select  : Chip select, defaults to 0
>
> This doesn't make a lot of sense to me. What is this property for? Is
> there more than one CS? And if there is, shouldn't the SPI driver be
> able to manipulate more than one?

Oh, wait, from reading the code, is this the number of chip select
lines? If so, then there is a common property for this. This property
should be named "num-cs".

>
>> +- tx_fifo_size : Overrides the default tx fifo size given in words
>> +- rx_fifo_size : Overrides the default rx fifo size given in words
>
> Nit: property names should use '-' instead of '_' (by convention) and
> custom properties should be prefixed with the manufacturer prefix to
> avoid namespace collisions. ie. "renesas,tx-fifo-size.
>
> g.



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
