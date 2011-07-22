From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 21 Jul 2011 17:21:36 -0700
Subject: [RFC PATCH v9 2/4] ARM: gic: Add PPI registration interface
In-Reply-To: <1311267448-14652-3-git-send-email-marc.zyngier@arm.com>
References: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
	<1311267448-14652-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E28C290.3090604@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> @@ -298,14 +289,23 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
>  	evt->min_delta_ns = clockevent_delta2ns(4, evt);
>  
> -	local_clock_event = evt;
> -
> -	gic_enable_ppi(clock->irq.irq);
> +	res = git_request_ppi(evt->irq, msm_timer_interrupt, evt);

Typo, should be gic_request_ppi.

Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
