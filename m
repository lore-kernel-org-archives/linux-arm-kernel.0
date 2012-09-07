From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Sep 2012 18:07:32 +0100
Subject: [PATCH v2 2/2] ARM: delay: add registration mechanism for delay
 timer sources
In-Reply-To: <1346275524-13817-2-git-send-email-will.deacon@arm.com>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
 <1346275524-13817-2-git-send-email-will.deacon@arm.com>
Message-ID: <20120907170729.GJ15916@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 10:25:24PM +0100, Will Deacon wrote:
> From: Jonathan Austin <Jonathan.Austin@arm.com>
> 
> The current timer-based delay loop relies on the architected timer to
> initiate the switch away from the polling-based implementation. This is
> unfortunate for platforms without the architected timers but with a
> suitable delay source (that is, constant frequency, always powered-up
> and ticking as long as the CPUs are online).
> 
> This patch introduces a registration mechanism for the delay timer
> (which provides an unconditional read_current_timer implementation) and
> updates the architected timer code to use the new interface.

[...]

> +int read_current_timer(unsigned long *timer_val)
> +{
> +	return delay_timer ? delay_timer->read_current_timer() : -ENXIO;
> +}

So this is clearly wrong with the new function prototype -- I've fixed it on
my delay branch (when the mirrors sync).

Will
