From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jul 2014 13:30:56 +0100
Subject: [PATCH v5 0/7] kernel: Add support for restart handler call chain
In-Reply-To: <1405668856-13738-1-git-send-email-linux@roeck-us.net>
References: <1405668856-13738-1-git-send-email-linux@roeck-us.net>
Message-ID: <20140721123056.GF12817@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 08:34:09AM +0100, Guenter Roeck wrote:
> Patch 1 of this series implements the restart handler function. Patches 2 and 3
> implement calling the restart handler chain from arm and arm64 restart code.
> 
> Patch 4 modifies the restart-poweroff driver to no longer call arm_pm_restart
> directly but machine_restart. This is done to avoid calling arm_pm_restart
> from more than one place. The change makes the driver architecture independent,
> so it would be possible to drop the arm dependency from its Kconfig entry.
> 
> Patch 5 and 6 convert existing restart handlers in the watchdog subsystem
> to use the restart handler. Patch 7 unexports arm_pm_restart to ensure
> that no one gets the idea to implement a restart handler as module.

For the current patches:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Do you plan to convert more of the power/drivers/reset/ code?

BTW, is it worth doing something similar for pm_power_off (there is
generic code calling it directly, so slightly more complicated than
pm_restart)?
