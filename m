From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 08:17:01 +0000
Subject: [PATCH 3/5] msm: timer: SMP timer support for msm
In-Reply-To: <alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-4-git-send-email-johlstei@codeaurora.org>
	<alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
Message-ID: <20101207081701.GA18336@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 10:56:14AM +0100, Thomas Gleixner wrote:
> On Sun, 5 Dec 2010, Jeff Ohlstein wrote:
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +void __cpuexit local_timer_stop(void)
> > +{
> > +	local_clock_event->set_mode(CLOCK_EVT_MODE_SHUTDOWN, local_clock_event);
> 
> Aarg. No. The generic code already handles cpu hotplug. 

Can you show where this is handled by the generic code?  I can't find
where this is handled.
