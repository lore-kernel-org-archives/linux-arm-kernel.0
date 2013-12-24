From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Dec 2013 16:58:04 -0800
Subject: [PATCH v2 1/3] clocksource: timer-keystone: introduce
 clocksource driver for Keystone
In-Reply-To: <1387297337-25493-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387297337-25493-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387297337-25493-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20131224005804.GF31766@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17, Ivan Khoronzhuk wrote:
> +static void __init keystone_timer_init(struct device_node *np)
> +{
> +	struct clock_event_device *event_dev = &timer.event_dev;
> +	unsigned long rate;
[...]
> +
> +	timer.hz_period = rate / (HZ);

Unnecessary parentheses here. Also, do you need to use do_div()
here? I'm lost how the hz_period is ever greater than 32 bits
though because HZ is most likely very small and the rate is
unsigned long.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
