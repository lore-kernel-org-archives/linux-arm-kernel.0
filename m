From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 21 May 2015 03:02:36 +0200
Subject: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1773599.T1QStsTFTH@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() but it has to
> guarantee that interrupts aren't enabled at any point in its execution,
> as the tick is frozen.
> 
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> 
> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> for both the enter() and enter_freeze() callbacks.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense to me, but I suppose it should go in via arm-soc.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
