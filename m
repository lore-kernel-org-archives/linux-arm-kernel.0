From: mark.roszko@gmail.com (Mark Roszko)
Date: Wed, 12 Mar 2014 22:28:51 -0400
Subject: [PATCH] pinctrl:at91:add drive strength configuration
In-Reply-To: <CACRpkdaRP_JBt3Qqb6M6PFOHcUVOdVFNTsE9fWv-U073B=3UcA@mail.gmail.com>
References: <20140121060637.GP9558@ns203013.ovh.net>
 <1390285991-1634-1-git-send-email-mark.roszko@gmail.com>
 <CACRpkdaRP_JBt3Qqb6M6PFOHcUVOdVFNTsE9fWv-U073B=3UcA@mail.gmail.com>
Message-ID: <CAJjB1q+LUQJvi8sbwNN0TQg9uyP8EL8r5TQUzLWrjnVbGzWw8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Can we get to know a bit more about default/low/medium and high?

Default is whatever the reset setting of the pins are. It's just a
placeholder for "do nothing" to alter the drive strength config. The
two groups of Atmel chips(SAMA5 and SAM9G series) have different reset
settings, i.e. the SAMA5 are "medium" while the SAM9Gs are "low".

Low, medium, high I can't really add much more than "see datasheet",
there are predefined output currents depending on pin and drive
strength configuration(low, medium,high).

>What I'm after is if this is drive strength in the sense of
>"number of driver stages" i.e. a number of extra mA per
>strength increase, usuall in 2mA or 4mA increases, so e.g.
>LOW=2mA, mid=4mA, high=6mA or if it's actually a
>slew rate thing designed for restricing the noise in silicon
>and/or electronics by providing a less steep slope containing
>less overtones. (This is usually done by another construction.)
>Which one is it?

The drive strength increases the output current capability of a pin.
Unfortunately the pins differ how they change as well, i.e. on a
SAMA5, PC0-PC14  will change from 8,26,38 mA (low,medium,high) while
PB0-PB27 will change 3,6,7 mA respectively.

>How does these different things relate? Do you have to set
>MULTI_DRIVE for the settings to work? Or is it leftover cruft?
>Or what is it?

MULTI_DRIVE is the term for Atmel's open-drain GPIO configuration per pin.
