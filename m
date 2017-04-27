From: bigeasy@linutronix.de (Sebastian Siewior)
Date: Thu, 27 Apr 2017 10:27:20 +0200
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170426103236.GI27156@leverpostej>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
Message-ID: <20170427082719.3wyru4bk67kdmflb@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-26 11:32:36 [+0100], Mark Rutland wrote:
> > So we could end up calling static_branch_enable_cpuslocked()
> > without actually holding the lock. Should we do a cpu_hotplug_begin/done in
> > setup_cpu_feature_capabilities ? I agree it doesn't look that nice. Thoughts ?
> 
> I agree that's hideous, but it looks like the only choice given the
> hotplug rwsem cahnges. :/

would work for you to provide a locked and unlocked version?

> I can spin a v2 with that and the typo fixes.
> 
> Thanks,
> Mark.

Sebastian
