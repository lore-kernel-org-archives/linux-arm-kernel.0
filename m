From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Thu, 17 Dec 2015 12:22:49 +0100
Subject: [PATCH v4] spi: dts: sun4i: Add support for wait time between
 word transmissions
In-Reply-To: <20151216103927.GS19456@lukather>
References: <1450080676-6704-1-git-send-email-mweseloh42@gmail.com>
 <20151216103927.GS19456@lukather>
Message-ID: <CAGNoLaN=HJ-OR6oFiGWC58DG+w1A9qeEVyGBRb1vdf9BRNW=Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

2015-12-16 11:39 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> It looks mostly fine, however, please try to make only one thing in
> one patch.
>
> In this case, it would mean having one patch to add the DT property
> and support in the SPI core in a first one, and then add support for
> it in your driver.

Will do.

> I also have a minor comment below....
[...]
>> +     if (spi->word_wait_ns) {
>> +             clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
>> +             wait_clk = DIV_ROUND_UP(spi->word_wait_ns, clk_ns) - 3;
>> +             if (wait_clk < 1) {
>> +                     wait_clk = 1;
>> +                     dev_info(&spi->dev,
>> +                              "using minimum of 4 word wait cycles (%uns)",
>> +                              4 * clk_ns);
>
> Logging it at the info loglevel seems a bit too high. debug seems more
> appropriate.

I will change it to debug and send a new version.

Thanks for the review!

Marcus
