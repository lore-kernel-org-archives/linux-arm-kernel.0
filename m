From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2015 23:09:44 +0100
Subject: [RFC PATCH v4 2/4] genirq: add move_irqs() for cpu hotplug
In-Reply-To: <alpine.DEB.2.11.1509172355260.3951@nanos>
References: <1442467166-1460-1-git-send-email-yangyingliang@huawei.com>
 <1442467166-1460-3-git-send-email-yangyingliang@huawei.com>
 <55FAEDF6.6060000@arm.com>
 <alpine.DEB.2.11.1509172355260.3951@nanos>
Message-ID: <20150917220944.GX21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:04:06AM +0200, Thomas Gleixner wrote:
> On Thu, 17 Sep 2015, Marc Zyngier wrote:
> > I don't think having this prototype guarded by this #if is very useful.
> > You can probably leave it standalone.
> 
> Yes, there is no point if the function name is unique. Though
> move_irqs() is rather undescriptive. irq_break_affinities() might
> describe it quite well, but feel free to come up with soemthing better.

I don't think "irq_break_affinities" is anywhere near a good name - it's
not about always breaking affinities (moving an IRQ off one CPU onto
another within the current affinity setting does not break the affinity.)

irq_migrate_all()

irq_migrate_all_off_this_cpu()

irq_this_cpu_hotunplug()

irq_cpu_hotunplug()

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
