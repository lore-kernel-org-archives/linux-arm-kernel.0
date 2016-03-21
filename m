From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 21 Mar 2016 11:29:14 +0100 (CET)
Subject: [PATCH v3 0/2] irqchip/mbigen: fix the IO remap problem in mbigen
 driver.
In-Reply-To: <1458203641-17172-1-git-send-email-majun258@huawei.com>
References: <1458203641-17172-1-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1603211124450.3978@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Mar 2016, MaJun wrote:
> This patch set is used to fix the problem of remap a set of registers
> repeatedly in current mbigen driver.
>
>   irqchip/mbigen:Change the mbigen node definition in dt binding file
>   irqchip/mbigen:Change the mbigen driver based on the new mbigen node definition

These subject lines are still horrible as they tell nothing about the nature
of the change. I fixed them up along with the changelogs and applied them to
irq/urgent. Can you spot the difference?

While at it. The config switch for this driver is horrible. It's just in the
middle of the device driver configs. Why is this configurable by the user at
all? It simply should be selected by arm64 or some subarch configuration
there. Please clean that up.

Thanks,

	tglx
