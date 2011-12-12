From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 13:49:04 +0000
Subject: [PATCH 2/4] ARM: smp_twd: create a percpu reference to the
 clockevent
In-Reply-To: <1323683830-23867-1-git-send-email-linus.walleij@stericsson.com>
References: <1323683830-23867-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111212134904.GV14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:57:10AM +0100, Linus Walleij wrote:
>  static unsigned long twd_timer_rate;
> +static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
>  
>  static struct clock_event_device __percpu **twd_evt;

So, one pointer to the clock_event_device is not enough?  Could we have
one or the other?
