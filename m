From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jan 2015 19:23:00 +0000
Subject: [PATCH 5/5] irqchip: gicv3-its: add support for power down
In-Reply-To: <1422604009-9248-6-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
 <1422604009-9248-6-git-send-email-wuyun.wu@huawei.com>
Message-ID: <54CBDA14.3010503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/15 07:46, Yun Wu wrote:
> Configurations of an ITS cannot be changed if the ITS is in an
> active status, so it might not be safe to perform a soft reboot
> with all the active ITSes un-disabled, etc. kexec.
> 
> This patch will make sure all the active ITSes disabled before
> enabling them again without resetting ITS hardware.

And what happens if the kernel crashes or gets rebooted from a watchdog?
Or if the bootloader messes things up? The ITS is in an unknown state
when we start again.

Wouldn't it be better to address this instead? Enforcing an safe initial
state seems a better solution that relying on mechanisms that may not be
relevant for all cases.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
