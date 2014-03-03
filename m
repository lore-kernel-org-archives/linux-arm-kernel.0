From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 03 Mar 2014 00:30:00 -0800
Subject: [PATCH V3 2/8] PM / Sleep / Runtime: Add
 pm_runtime_suspend|resume_force functions
In-Reply-To: <1393671371-2398-3-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Sat, 1 Mar 2014 11:56:05 +0100")
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hppm3sn07.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> This patch provides two new runtime PM helper functions which intend to
> be used from system suspend/resume callbacks, to make sure devices are
> put into low power state during system suspend and brought back to full
> power at system resume.
>
> The prerequisite is to have all levels of a device's runtime PM
> callbacks to be defined through the SET_PM_RUNTIME_PM_OPS macro, which
> means these are available for CONFIG_PM.
>
> By using the new runtime PM helper functions especially the two
> scenarios below will be addressed.
>
> 1) The PM core prevents .runtime_suspend callbacks from being invoked
> during system suspend. That means even for a runtime PM centric
> subsystem and driver, the device needs to be put into low power state
> from a system suspend callback. Otherwise it may very well be left in
> full power state (runtime resumed) while the system is suspended. By
> using the new helper functions, we make sure to walk the hierarchy of
> a device's power domain, subsystem and driver.
>
> 2) Subsystems and drivers need to cope with all the combinations of
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions
> smothly addresses this.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

FWIW

Acked-by: Kevin Hilman <khilman@linaro.org>
