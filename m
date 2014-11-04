From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Nov 2014 11:00:46 +0100
Subject: [PATCH 10/17] ARM: mvebu: implement suspend/resume support for
 Armada XP
In-Reply-To: <1414151970-6626-11-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-11-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5458A3CE.70900@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

[...]

> +static int mvebu_pm_enter(suspend_state_t state)
> +{
> +	if (state != PM_SUSPEND_MEM)
> +		return -EINVAL;
> +
> +	cpu_pm_enter();
> +	cpu_cluster_pm_enter();

Why do you use this function?

It notifies the listeners with CPU_CLUSTER_PM_ENTER but currently only omap2
and the gic are waiting for it.

Do you already plan to be compatible with the cortex A9 based mvebu SoC?

By the way the gic doesn't use the suspend and resume operation from syscore_ops
but the notification. Is there any particular reason for using syscore_ops in
the irq-armada-370-xp driver?


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
