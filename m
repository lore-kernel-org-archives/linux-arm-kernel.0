From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 14 Dec 2015 09:08:09 +0100
Subject: [PATCH v3] spi: dts: sun4i: Add support for hardware-based wait
 time between words
In-Reply-To: <CAGNoLaOckrgv5NP6eTOt8shj5f069DKFrxx+8afydqcAZH5HMw@mail.gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
 <1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
 <20151214012937.GA12209@rob-hp-laptop>
 <CAGNoLaOckrgv5NP6eTOt8shj5f069DKFrxx+8afydqcAZH5HMw@mail.gmail.com>
Message-ID: <CAGNoLaMR48FP6LA6OCUiwBFpja_inx47f-7hzLC3+=6td6oeaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-14 8:31 GMT+01:00 Marcus Weseloh <mweseloh42@gmail.com>:
> [...]
>>> +     /* Setup wait time between words */
>>> +     of_property_read_u32(spi->dev.of_node, "spi-word-wait-ns",
>>> +                          &wait_ns);
>>
>> Read this in probe and save the value rather than fetching every
>> transfer.
>
> But this is a slave property I'm using here. If I read and store it in
> probe in the spi-sun4i driver, I won't have access to the slave node
> property, will I?

Sorry, I think I get it now. I would need to read the value in SPI
core, when the slave device gets probed. I will send an updated patch.

Thanks,

    Marcus
