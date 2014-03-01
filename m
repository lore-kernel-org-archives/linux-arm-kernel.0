From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 02 Mar 2014 00:38:47 +0100
Subject: [PATCH V3 0/8] PM / Sleep / Runtime: Fixup some driver's system
 suspend
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7021741.2WcVMr4q95@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 01, 2014 11:56:03 AM Ulf Hansson wrote:
> Patch 1 -> 2:
> These patches provides two new runtime PM helper functions which intend to be
> used from system suspend/resume callbacks, to make sure devices are put into low
> power state during system suspend and brought back to full power at system
> resume.
> 
> The prerequisite is to have all levels of a device's runtime PM callbacks to be
> defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
> for CONFIG_PM.
> 
> By using the new runtime PM helper functions especially the two scenarios below
> will be addressed.
> 
> 1) The PM core prevents .runtime_suspend callbacks from being invoked during
> system suspend. That means even for a runtime PM centric subsystem and driver,
> the device needs to be put into low power state from a system suspend callback.
> Otherwise it may very well be left in full power state (runtime resumed) while
> the system is suspended. By using the new helper functions, we make sure to walk
> the hierarchy of a device's power domain, subsystem and driver.
> 
> 2) Subsystems and drivers need to cope with all the combinations of
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions smothly
> addresses this.

OK, I've queued up [1-2/8] for 3.15.  The rest generally didn't apply for me
and I think it'd be better to push them through the respective subsystem trees
later anyway.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
