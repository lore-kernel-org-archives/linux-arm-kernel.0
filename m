From: jiada_wang@mentor.com (Jiada Wang)
Date: Thu, 13 Apr 2017 22:39:30 -0700
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
Message-ID: <58F06092.9080409@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert

On 04/13/2017 12:47 PM, Geert Uytterhoeven wrote:
> On Thu, Apr 13, 2017 at 2:59 PM, Mark Brown<broonie@kernel.org>  wrote:
>> On Thu, Apr 13, 2017 at 05:13:59AM -0700, jiada_wang at mentor.com wrote:
>>> From: Jiada Wang<jiada_wang@mentor.com>
>>>
>>> v1:
>>>    add Slave mode support in SPI core
>>>    spidev create slave device when SPI controller work in slave mode
>>>    spi-imx support to work in slave mode
>> Adding Geert who also had a series doing this in progress that was
>> getting very near to being merged.
> Thank you!
>
> Actually my plan is to fix the last remaining issues and resubmit for v4.13.
I noticed your patch set for SPI slave support,
(I am sure you can find out some of the change
in this patch set is based on your work).
we have similar requirement to add slave mode support to ecspi IP on 
imx6 Soc.

Our use case is to use spidev as an interface to communicate with 
external SPI master devices.
meanwhile the SPI bus controller can also act as master device to send 
data to other
SPI slave devices on the board.

I found in your implementation, SPI bus controller is limited to either 
work in master mode or
slave mode, is there any reasoning to not configure SPI mode based on 
SPI devices use case?


Thanks,
Jiada

> References:
>    - v2: https://lkml.org/lkml/2016/9/12/1065
>    - v1: https://lkml.org/lkml/2016/6/22/423
>
> BTW Jiada, what's your use case? Just spidev?
>
> Thx!
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
