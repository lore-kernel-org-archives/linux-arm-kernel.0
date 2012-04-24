From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 15:01:30 +0200
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <4F95A71B.6090808@wwwdotorg.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <4F95A71B.6090808@wwwdotorg.org>
Message-ID: <CACRpkdYr_=a+c88BjJdrtryS0DP6khjf4tsQPm=EogvZQnZytg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 9:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/23/2012 08:46 AM, Shawn Guo wrote:

>> I think I have a understanding on "function" defined by pinctrl
>> subsystem. ?To me, mmc0-4bit and mmc0-8bit are two functions.
>> Linus, help clarify a little bit?
>
> I suppose there may be disagreement on this, but to me, a function is a
> specific mux option (the HW register value typically) that can be
> selected for a particular pin. Typically, these mux options would
> correspond directly to the HW module whose signals were being muxed onto
> that pin.
>
> So for example, Tegra might have the following mux options for some pin:
>
> SDHCI 1 ? ? # controller 1
> SDHCI 2 ? ? # controller 2
>
> but would not have these:
>
> SDHCI 1 4 bit ? ?# controller 1
> SDHCI 1 8 bit ? ?# controller 1
> SDHCI 2 4 bit ? ?# controller 2
> SDHCI 2 8 bit ? ?# controller 2
>
> the difference between 4 bit and 8 bit would be purely driven by which
> pins/groups the two controllers were mux'd onto. (Unless the pin
> controller HW needed explicit notification of the difference for some
> reason - certainly not the case for Tegra)
>
> Of course, this is all without virtual functions. If you're doing
> virtual functions, the second set of functions I listed above, with 4
> entries, might well be what you'd end up with. But I dislike that since
> you're not representing the pure HW capabilities as functions, but
> rather some higher level grouped concept.

Yeah Stephen pretty much nailed it there.

I am more liberal about what functions represent and I'm happy
with them representing values poked to several registers, that's
something we disagree on from time to time.

We all agree (I think) that when there is no pin-level mux control
(such as in the U300) but several pins are muxed with a single
register bit or so, then we must define a function encompassing
many pins.

Yours,
Linus Walleij
