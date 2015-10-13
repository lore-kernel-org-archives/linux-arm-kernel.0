From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Oct 2015 20:28:24 +0100
Subject: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
Message-ID: <20151013192824.GL32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 05:32:15PM +0800, Yang Yingliang wrote:
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, the old affinity need
> to be updated and if irq_set_affinity's return value is IRQ_SET_MASK_OK_DONE,
> the old affinity can not be updated. Fix it by using irq_do_set_affinity.
> 
> And migrating interrupts is a core code matter, so use the generic
> function irq_migrate_all_off_this_cpu() to migrate interrupts in
> kernel/irq/migration.c.

Please can you put this patch in the patch system so I don't forget it
(it's taken tglx prompting and quite a long time to find this in my
mailbox already.)

See http:/www.arm.linux.org.uk/developer/patches/

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
