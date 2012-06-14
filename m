From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2012 19:25:48 +0200
Subject: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <4FD9A328.9080000@linaro.org>
References: <201206140804.39083.arnd@arndb.de>
 <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
 <20120614081758.GA19648@mail.gnudd.com>
 <4FD9A328.9080000@linaro.org>
Message-ID: <CACRpkdZfherHBEXcwaco1zeK-gW=3x-rGXTfNc4QwwWfLk_JRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 14/06/12 09:17, Alessandro Rubini wrote:
>>>
>>> You change only one half of ux500 here: the part where the device
>>> gets defined statically, but not not the definition in the
>>> device-tree.
>>
>> Yes, I'm aware. That's why I added Lee Jones as Cc:, on Linusw's
>> suggestion. ?Lee told me to go ahead and he'll fix the DT stuff.
>
> I did?

Yes :-)

> I have already DT:ed this driver. There are 3 patches on the MLs currently.
>
>> [PATCH 1/3] i2c: Add Device Tree support to the Nomadik I2C driver
>> [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree for
>> DB8500 based devices
>> [PATCH 3/3] Documentation: Device Tree binding information for i2c-nomadik
>> driver
>
> I'm more than happy for you to base your patches on these and make the
> necessary changes. Off hand, I think the only changes you'll need to make is
> the probing from DT itself.

Depends on whether this patch or yours go in first I guess. Which
is up to Wolfram. What I know is that Alessandros patches are
ready to merge IMO.

> So something like:
>
>    -                       compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
>    +                       compatible = "st,nomadik-i2c", "arm,primecell";

Yep that should do it.

Which brings me to the fear of what happens the day we have
deployed device trees out there and just cannot change things
like this easily :-/

Yours,
Linus Walleij
