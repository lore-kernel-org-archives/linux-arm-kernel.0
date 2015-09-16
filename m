From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Sep 2015 10:21:57 +0200 (CEST)
Subject: [RFC PATCH v3 3/3] arm/arm64: fix a migrating irq bug when
 hotplug cpu
In-Reply-To: <1442375907-11496-4-git-send-email-yangyingliang@huawei.com>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
 <1442375907-11496-4-git-send-email-yangyingliang@huawei.com>
Message-ID: <alpine.DEB.2.11.1509161013430.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015, Yang Yingliang wrote:
>  arch/arm/Kconfig             |  1 +
>  arch/arm/include/asm/irq.h   |  1 -
>  arch/arm/kernel/irq.c        | 62 -----------------------------------------
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/irq.h |  1 -
>  arch/arm64/kernel/irq.c      | 62 -----------------------------------------
>  include/linux/irq.h          |  4 +++
>  kernel/irq/migration.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++

This want's to be split into seperate patches:

#1 Provide the core infrastructure

#2 Switch ARM to use it

#3 Switch ARM64 to use it

Thanks,

	tglx
