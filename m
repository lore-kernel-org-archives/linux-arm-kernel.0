From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 7 Sep 2011 12:02:52 +0200 (CEST)
Subject: [PATCH 3/4] mach-integrator: modernize clock event
 registration
In-Reply-To: <1315384260-27404-1-git-send-email-linus.walleij@stericsson.com>
References: <1315384260-27404-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1109071202000.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Drop the reload value for the timer - the timekeeping code
> will call the .set_next_event to set this anyway.
> 
> Drop mult, shift and delta calculations and let the
> clockevent core scale this as appropriate.
> 
> Set the minimum interval to 1 rather than 15 (0xf), there
> is nothing in the data sheets I have indicating that 15
> should be some minimum value.
> 
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
