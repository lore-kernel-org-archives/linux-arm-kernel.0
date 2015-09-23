From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 23 Sep 2015 12:16:00 +0800
Subject: [RFC PATCH v5 2/4] genirq: add irq_migrate_all_off_this_cpu() for
 cpu hotplug
In-Reply-To: <alpine.DEB.2.11.1509222050300.5606@nanos>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
 <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1509222050300.5606@nanos>
Message-ID: <56022780.1030308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/23 2:54, Thomas Gleixner wrote:
> On Sat, 19 Sep 2015, Yang Yingliang wrote:
>
>> Add irq_migrate_all_off_this_cpu() into kernel/irq/migration.c.
>
> This doesn't make any sense at all.
>
> You just reuse the existing file to stick your new code into it
> without reusing a single bit in that file. Aside of that it's
> unconditionally compiled, which means all existing users of
> CONFIG_GENERIC_PENDING_IRQ are burdened with pointless code.
>
> The right thing to do is:
>
> Add that code to a new file: kernel/irq/cpuhotplug.c and make that
> depend on CONFIG_GENERIC_IRQ_MIGRATION.

How about add #ifdef CONFIG_CPU_HOTPLUG around new code
in kernel/irq/migration.c ?

Thanks,
Yang
