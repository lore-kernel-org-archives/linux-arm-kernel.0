From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Nov 2010 11:50:38 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound v4
In-Reply-To: <20101118082429.GJ8942@pengutronix.de>
References: <1290067462-26924-1-git-send-email-linus.walleij@stericsson.com>
	<20101118082429.GJ8942@pengutronix.de>
Message-ID: <4CE504FE.9050103@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:

>> +unsigned long long sched_clock(void)
>
> Before your patch sched_clock was marked notrace.  Did you remove that
> on purpose?

Yes actually, and then the other day I saw Rabins patch adding
it to each and every machine. And I think Tim put out a similar
patch not too long ago.

Frederic Weisbecker then remarked that the sched_clock
prototype in sched.h already includes notrace. So it's
not strictly required the way I read it.

So with this in my back head I removed it.

But I guess I'll just re-add it for clarity, why not.

Yours,
Linus Walleij
