From: rpurdie@rpsys.net (Richard Purdie)
Date: Tue, 12 Jan 2010 09:32:25 +0000
Subject: [PATCH v2 06/09] backlight: enable backlight in 88pm860x
In-Reply-To: <771cded01001110032s7fe62605g72cdb50b73d0d53@mail.gmail.com>
References: <771cded00912090515k39cccec9od78addb8e127f491@mail.gmail.com>
	<20100108110646.GB3734@sortiz.org>
	<1262953648.10097.34.camel@dax.rpnet.com>
	<771cded01001110032s7fe62605g72cdb50b73d0d53@mail.gmail.com>
Message-ID: <1263288745.17518.65.camel@ted>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 03:32 -0500, Haojian Zhuang wrote:
> On Fri, Jan 8, 2010 at 7:27 AM, Richard Purdie <rpurdie@rpsys.net> >
> In the LED patch I'm not sure I like the SET_BRIGHTNESS and SET_BLINK
> > sharing of a workqueue though. Its not going to crash, I can just see
> > values potentially getting lost as the code has a race condition. It
> > would be easier if it just compared led->current_brightness to
> > led->brightness acting if needed and something similar for LED blinking.
>
> Excuse me that there's a mutex lock in __led_set(). Both
> SET_BRIGHTNESS & SET_BLINK calls __led_set(). There shouldn't be race
> condition on set led. What's your opinion?

There is a race condition since if you get a blink and brightness set
call at around the same time, only one of them will end up being
applied. Its not going to crash but its also less than ideal.

Cheers,

Richard
