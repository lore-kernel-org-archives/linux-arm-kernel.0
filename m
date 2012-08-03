From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 3 Aug 2012 08:22:15 +0000
Subject: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
In-Reply-To: <501B7AE6.8080405@gmail.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
 <501B7AE6.8080405@gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7F2F9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 12:46:54, Daniel Mack wrote:
> On 30.03.2012 15:27, Santosh Shilimkar wrote:
> > For coupled cpuidle to work when both cpus are active, it needs a global timer
> > that can handle events for both cpus.  This timer is used as the broadcast
> > clock-event when the per-cpu timer hardware stop in low power states.
> > Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
> > set the irq to allow the clockevent core to determine the affinity of the
> > timer.
> 
> These patches made it to mainline now, shortly befor 3.6-rc1, and it
> breaks boot on my AM33xx board.
> 

Thanks Daniel for testing and reporting. I haven't tried 3.6-rc1 yet, as 
omap-linux/master has not yet migrated to it.
I am testing it now, and will let you know on the status.

Thanks,
Vaibhav
