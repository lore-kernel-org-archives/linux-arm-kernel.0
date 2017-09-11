From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Sep 2017 21:37:16 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
Message-ID: <CACRpkdb4LQAqyWpRAWGRxUOcTbWVksNc3FTWdPnYNE-AUHtfgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 1:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> This converts the GPIO-based I2C-driver to using GPIO
>> descriptors instead of the old global numberspace-based
>> GPIO interface. We:
>>
>> - Convert the driver to unconditionally grab two GPIOs
>>   from the device by index 0 (SDA) and 1 (SCL) which
>>   will work fine with device tree and descriptor tables.
>>   The existing device trees will continue to work just
>>   like before, but without any roundtrip through the
>>   global numberspace.
>
> FYI, I recently posted a series to deprecate (at least for DT) this error
> prone indexing, in favor of using named GPIOs:
>
>     [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
>     http://www.spinics.net/lists/devicetree/msg191936.html

Nice.

If Wolfram likes this series, I volunteer to rebase your patch
(oh well rewrite patch 2 from scratch, haha) on top of it as well
so he can apply the whole thing.

They will need some adjustments, I volunteer to do them.
Will provide feedback in the patches.

Yours.
Linus Walleij
