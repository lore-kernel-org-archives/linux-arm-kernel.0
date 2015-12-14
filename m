From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 14 Dec 2015 08:31:55 +0100
Subject: [PATCH v3] spi: dts: sun4i: Add support for hardware-based wait
 time between words
In-Reply-To: <20151214012937.GA12209@rob-hp-laptop>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
 <1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
 <20151214012937.GA12209@rob-hp-laptop>
Message-ID: <CAGNoLaOckrgv5NP6eTOt8shj5f069DKFrxx+8afydqcAZH5HMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2015-12-14 2:29 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Mon, Dec 14, 2015 at 12:04:11AM +0100, Marcus Weseloh wrote:
>> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
[...]
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index bbaa857..2d6034f 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -61,6 +61,8 @@ contain the following properties.
>>                        used for MOSI. Defaults to 1 if not present.
>>  - spi-rx-bus-width - (optional) The bus width(number of data wires) that
>>                        used for MISO. Defaults to 1 if not present.
>> +- spi-word-wait-ns - (optional) Hardware based delay between transmission of
>> +                      words in nanoseconds
>
> Could be a software delay if the h/w doesn't support delays.

Of course, I was still trapped in my sun4i specific thinking. Will
remove the hardware reference.

[...]
>> +     /* Setup wait time between words */
>> +     of_property_read_u32(spi->dev.of_node, "spi-word-wait-ns",
>> +                          &wait_ns);
>
> Read this in probe and save the value rather than fetching every
> transfer.

But this is a slave property I'm using here. If I read and store it in
probe in the spi-sun4i driver, I won't have access to the slave node
property, will I?

Cheers,

    Marcus
