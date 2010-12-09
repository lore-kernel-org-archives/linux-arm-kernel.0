From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 09 Dec 2010 18:55:30 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
Message-ID: <1291917330.6803.7.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 09:43 -0800, Venkatesh Pallipadi wrote:
> 
> The same problem will be there with below code, with irq_delta >
> delta, clock_task can go backwards which is not good.
> +       delta -= irq_delta;
> +       rq->clock_task += delta;
> 
> The reason for this is rq->clock and irqtime updates kind of happen
> independently and specifically, if a rq->clock update happens while we
> are in a softirq, we may have this case of going backwards on the next
> update.

But how can irq_delta > delta?, we measure it using the same clock.
