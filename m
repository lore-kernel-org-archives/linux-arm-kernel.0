From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 22 Sep 2015 20:54:19 +0200 (CEST)
Subject: [RFC PATCH v5 2/4] genirq: add irq_migrate_all_off_this_cpu()
 for cpu hotplug
In-Reply-To: <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
 <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
Message-ID: <alpine.DEB.2.11.1509222050300.5606@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2015, Yang Yingliang wrote:

> Add irq_migrate_all_off_this_cpu() into kernel/irq/migration.c.

This doesn't make any sense at all. 

You just reuse the existing file to stick your new code into it
without reusing a single bit in that file. Aside of that it's
unconditionally compiled, which means all existing users of
CONFIG_GENERIC_PENDING_IRQ are burdened with pointless code.

The right thing to do is:

Add that code to a new file: kernel/irq/cpuhotplug.c and make that
depend on CONFIG_GENERIC_IRQ_MIGRATION.

Thanks,

	tglx
