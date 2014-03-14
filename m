From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 10:44:44 +0100
Subject: [PATCH] pinctrl:at91:add drive strength configuration
In-Reply-To: <CAJjB1q+LUQJvi8sbwNN0TQg9uyP8EL8r5TQUzLWrjnVbGzWw8w@mail.gmail.com>
References: <20140121060637.GP9558@ns203013.ovh.net>
 <1390285991-1634-1-git-send-email-mark.roszko@gmail.com>
 <CACRpkdaRP_JBt3Qqb6M6PFOHcUVOdVFNTsE9fWv-U073B=3UcA@mail.gmail.com>
 <CAJjB1q+LUQJvi8sbwNN0TQg9uyP8EL8r5TQUzLWrjnVbGzWw8w@mail.gmail.com>
Message-ID: <CACRpkdbHy7133SxjALC+24FOYkTfRgTiC8-yrpDgUn5U1V7skA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 3:28 AM, Mark Roszko <mark.roszko@gmail.com> wrote:

>>What I'm after is if this is drive strength in the sense of
>>"number of driver stages" i.e. a number of extra mA per
>>strength increase, usuall in 2mA or 4mA increases, so e.g.
>>LOW=2mA, mid=4mA, high=6mA or if it's actually a
>>slew rate thing designed for restricing the noise in silicon
>>and/or electronics by providing a less steep slope containing
>>less overtones. (This is usually done by another construction.)
>>Which one is it?
>
> The drive strength increases the output current capability of a pin.
> Unfortunately the pins differ how they change as well, i.e. on a
> SAMA5, PC0-PC14  will change from 8,26,38 mA (low,medium,high) while
> PB0-PB27 will change 3,6,7 mA respectively.

First I'd like you to document exactly that above the #defines
in the driver
#define AT91_PINCTRL_DRIVE_STRENGTH_LOW
etc.

So this adds more magic to these 3 bits in the config word,
oh well I guess we have to live with this unless you switch over
to generic pin config any time soon.

>>How does these different things relate? Do you have to set
>>MULTI_DRIVE for the settings to work? Or is it leftover cruft?
>>Or what is it?
>
> MULTI_DRIVE is the term for Atmel's open-drain GPIO configuration per pin.

Hm. That could need a specific comment/documentation entry
I think. (Separate patch.)

Yours,
Linus Walleij
