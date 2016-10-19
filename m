From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 19 Oct 2016 11:01:53 -0700
Subject: [PATCH v4] MMC: meson: initial support for GX platforms
In-Reply-To: <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
 (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 13:20:54
 -0300")
References: <20161018195605.21145-1-khilman@baylibre.com>
 <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
Message-ID: <7hinso8bfy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier@dowhile0.org> writes:

> Hello Kevin,
>
> On Tue, Oct 18, 2016 at 4:56 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
>> family of SoCs.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> [snip]
>
>> +
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>
> Why is this module alias needed? I thought that the Amlogic was a
> DT-only platform and so devices will always be registered from OF (and
> the OF modalias used).

You're right, I probably copy/pasted it from another driver.

Testing without it also made me realize that the module filename (meson_gx)
isn't really useful when listed in lsmod, so I 'll respin to have mmc in
the filename so the module name also shows mmc.

Kevin
