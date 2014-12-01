From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 01 Dec 2014 11:51:03 -0800
Subject: [PATCH v10 0/4] This suspend patch is only support cut off the
 power of cpu and some external
In-Reply-To: <1417423940-1669-1-git-send-email-zyw@rock-chips.com> (Chris
 Zhong's message of "Mon, 1 Dec 2014 16:52:16 +0800")
References: <1417423940-1669-1-git-send-email-zyw@rock-chips.com>
Message-ID: <7htx1f409k.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris Zhong <zyw@rock-chips.com> writes:

> devices, since we still lack power_domain driver, so the other power rail
> of rk3288 need keep power on.
> I have tested it on rk3288-evb board, atop next-20141112. goto suspend by type
> "echo mem > /sys/power/state", vdd_cpu is about 0mv by measuring, so it can be
> determined in sleep mode, then press power button to wakeup it.

I tested this on top of today's linux-next (next-20141201) and it
suspends, but doesn't wake up from any of the button presses.  What
wakeup sources are configured for the rk3288-evb-rk808?

Kevin
