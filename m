From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jan 2015 19:10:13 +0000
Subject: [PATCH 1/5] irqchip: gicv3-its: allocate proper size for DT
In-Reply-To: <1422604009-9248-2-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
 <1422604009-9248-2-git-send-email-wuyun.wu@huawei.com>
Message-ID: <54CBD715.9040000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/15 07:46, Yun Wu wrote:
> A hardware implementation may be designed to search the device
> table (DT) using a direct mapping between device ID and memory
> address, and in this scenario a single page, currently allocated
> for DT in ITS driver, will be probably not enough.
> 
> This patch will try best to get this addressed by enlarging DT
> size with a limitation of MAX_ORDER pages.
> 
> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>

A similar patch has been posted already (and is already in my queue):

https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-fixes&id=4be3de2af2a58476f84d678f3e8a3596f23f80d5

	M.
-- 
Jazz is not dead. It just smells funny...
