From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 1 Jun 2016 09:03:23 +0200 (CEST)
Subject: [PATCH 1/2] clocksource: Add Oxford Semiconductor RPS Dual Timer
In-Reply-To: <1464688198-9655-2-git-send-email-narmstrong@baylibre.com>
References: <1464688198-9655-1-git-send-email-narmstrong@baylibre.com>
 <1464688198-9655-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <alpine.DEB.2.11.1606010902260.3629@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2016, Neil Armstrong wrote:
> +static int oxnas_rps_timer_shutdown(struct clock_event_device *evt)
> +{
> +	struct oxnas_rps_timer *rps =
> +		container_of(evt, struct oxnas_rps_timer, clkevent);
> +
> +	if (!clockevent_state_periodic(evt))
> +		return 0;

So if the timer is in oneshot mode, then you just leave it enabled. What's the
rationale of this?

> +
> +	oxnas_rps_timer_config(rps, 0, 0);

Thanks,

	tglx
