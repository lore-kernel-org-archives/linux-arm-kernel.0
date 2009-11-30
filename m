From: david-b@pacbell.net (David Brownell)
Date: Mon, 30 Nov 2009 12:38:35 -0800
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
Message-ID: <200911301238.35750.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2009, Alan Cox wrote:
> SHARED|DISABLED ought to WARN_ON() and if that doesn't motivate people
> then return -EINVAL. And with any luck that'll prove 6 months later that
> most of the offenders are not used and we can delete them wholesale.

So ... merge an updated version of the original patch, to
get full WARN coverage?

We've had that warning for a long time now.  The original
patch just covered non-request_irq() cases.  So by your
timetable we're ready for the "return -EINVAL" stage of
the migration... at least, for request_irq() callers.
