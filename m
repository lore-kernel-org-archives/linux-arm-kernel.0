From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Jan 2012 15:29:52 -0800
Subject: [PATCH v2 13/15] ARM: local timers: convert exynos to runtime
 registration interface
In-Reply-To: <1326479322-6033-14-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120113232952.GA20679@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 06:28:40PM +0000, Marc Zyngier wrote:

> +static struct local_timer_ops exynos4_mct_tick_ops __initdata = {
> +	.setup	= exynos4_local_timer_setup,
> +	.stop	= exynos4_local_timer_stop,
> +};

This also needs to be __cpuinitdata

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
