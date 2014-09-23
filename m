From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Sep 2014 23:22:54 +0200
Subject: [PATCH v3] ARM: zImage: add support for ARMv7-M
In-Reply-To: <CAGhQ9VzQSphUoW+rSRdwHVrgrzEEcCoaTKYUA_BntK97zqdY7g@mail.gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <1411494565-29534-1-git-send-email-manabian@gmail.com>
 <20140923193251.GB3755@pengutronix.de>
 <CAGhQ9VzQSphUoW+rSRdwHVrgrzEEcCoaTKYUA_BntK97zqdY7g@mail.gmail.com>
Message-ID: <20140923212254.GD3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Tue, Sep 23, 2014 at 10:42:57PM +0200, Joachim Eastwood wrote:
> On 23 September 2014 21:32, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> >> index 413fd94b5301..cd27090625fe 100644
> >> --- a/arch/arm/boot/compressed/head.S
> >> +++ b/arch/arm/boot/compressed/head.S
> >> [...]
> >> @@ -114,7 +117,7 @@
> >>   * sort out different calling conventions
> >>   */
> >>               .align
> >> -             .arm                            @ Always enter in ARM state
> >> + AR_CLASS(   .arm    )               @ Always enter in ARM state for A/R classes
> > Semantically we don't want .arm when CPU_THUMBONLY is enabled. At least
> > currently this is equivalent with !AR_CLASS. Maybe this is worth to be
> > pointed out in a comment?
> 
> Won't THUMBONLY always mean !AR_CLASS?
I don't know what ARM (the company) will invent in the future.
Today it's equivalent, yes.

> Do you have a particular comment in mind?
Something like:

	Always enter in ARM state for CPUs that support the ARM ISA.
	As of today (2014) that's exactly the members of the A and R
	classes.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
