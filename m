From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 May 2013 11:48:51 +0200
Subject: [RFC patch 0/8] genirq: Support for irq domains in generic irq
 chip
In-Reply-To: <20130503212258.385818955@linutronix.de>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
Message-ID: <20130506094851.GI23285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 03, 2013 at 09:50:43PM -0000, Thomas Gleixner wrote:
> The ongoing device tree support for ARM is creating new irq chip
> drivers in drivers/irqchip/ in a frenzy. Quite some of them are
> ripping out the generic irq chip implementation from arch/arm/* and
> just creating the same mess of duplicated code again, which was
> cleaned up with the generic irq chip implementation with a lot of
> effort. Sigh!
> 
> I already prodded a few people in reviews to tackle that issue with no
> outcome. Even more sigh!
> 
> Poor Sebastian triggered me into rant mode, but he ad hoc
> volunteered to give it a try. YAY!
> 
> Though he asked for a bit of kickstart help. So I squeezed out a few
> spare cycles and implemented the basics as far as I think that they
> should work.
> 
> The following series contains the missing bits and pieces including a
> somehow forgotten and now slightly modified series from Gerlando
> adding support for irq chips which need separate mask caches for
> different chip (control flow) types.
> 
> At the moment this supports only linear irq domains, but it could be
> extended to other types as well if the need arises. Though the ARM
> chips are pretty much all about linear domains AFAICT.
Is there a tree/set of patches that have already fixed the issues
pointed out by Russell and Sebastian? I'd like to use it to get forward
with my nvic patch and want to avert double work and merging different
approaches.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
