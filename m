From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Apr 2013 10:23:17 -0700
Subject: [PATCH] spi: s3c64xx: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=W++WXLOazKR=f6PHdzr=AVOwyT2i=swNtw6yMOJhJgmA@mail.gmail.com>
References: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=W++WXLOazKR=f6PHdzr=AVOwyT2i=swNtw6yMOJhJgmA@mail.gmail.com>
Message-ID: <CAD=FV=V99ucNRuZ3iAb7Eh5XTmWNRVOXqP8af_a6ii98hoV76Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, Mar 11, 2013 at 10:36 AM, Doug Anderson <dianders@chromium.org> wrote:
> Thomas,
>
> On Wed, Mar 6, 2013 at 3:42 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> With device core now able to setup the default pin configuration,
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  .../devicetree/bindings/spi/spi-samsung.txt        |    8 +--
>>  drivers/spi/spi-s3c64xx.c                          |   66 +------------------
>>  2 files changed, 6 insertions(+), 68 deletions(-)

Is this something you would pick up?  It looks like you weren't copied
on the original email thread, unfortunately.

Without this (or some equivalent) patch we can't use the SPI driver on
any SoCs that have switched over to the proper pinmux support.

Thanks!

-Doug
