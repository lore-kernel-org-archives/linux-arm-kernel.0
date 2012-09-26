From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Sep 2012 19:03:49 +0100
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <20120925150026.GG21730@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120816202932.GY2232@pengutronix.de>
 <20120921190002.GU5525@pengutronix.de> <5061C3FE.7050400@arm.com>
 <20120925150026.GG21730@pengutronix.de>
Message-ID: <20120926180349.GF15578@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Sep 25, 2012 at 04:00:26PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Sep 25, 2012 at 03:47:26PM +0100, Jonathan Austin wrote:
> > Looking at the patch series at a very superficial level, I wonder why
> > you've chosen not to include any Kconfig/NVIC support at this stage,
> > especially as you've posted some before and there appears to be
> > something (presumably) working in your efm32 branch...
> >
> > It would be a shame to spend time on merging the basic support if there
> > are issues that mean the interrupt support won't follow.
> I plan to expand common/gic.c for interrupt support. Currently I don't
> do much though because getting feedback and the changes into mainline is
> quite hard and I don't want to spend time now and hear later that I did
> it wrong or something. So I put my efforts on hold and only ping from
> time to time.  :-(

My personal view is that merging the code without support for interrupts is
fairly pointless, so the nvic code should certainly be included. I
wouldn't worry too much about merging it with gic.c initially. That can come
later, especially as we'll need to prise the gic into drivers/ at some point
(it should be shared with arm64).

I think one reason for the lack of feedback is the inability for people to
run this code themselves. I believe Jonny was trying to get started with an
FPGA / simulation, but some hardware would be great if there's any available...

Cheers,

Will
