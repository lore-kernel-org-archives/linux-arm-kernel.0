From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Sep 2015 12:19:18 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <55FA9099.7000903@linaro.org>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
 <55FA83D5.9010504@linaro.org> <55FA87AA.4040807@gmail.com>
 <55FA9099.7000903@linaro.org>
Message-ID: <alpine.DEB.2.11.1509171217080.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015, Daniel Lezcano wrote:
> On 09/17/2015 11:28 AM, Caesar Wang wrote:
> > > I think the NO_IRQ definition is missing for ARM64.
> > 
> > Yep, Maybe better to compatible if we don't use the 'NO_IRQ',
> 
> Hmm, after digging into drivers/of/irq.c and kernel/irq/irqdomain.c
> 
> when there is an error it returns zero. So NO_IRQ and -1 are not correct and
> on the other side zero can be a valid irq. That sounds a little bit fuzzy to
> me.

IRQ0 is invalid for historical reasons. End of story.

Thanks,

	tglx
