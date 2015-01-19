From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jan 2015 13:19:31 +0000
Subject: [Query] ARM64 : arm_pm_restart intialization
In-Reply-To: <BLUPR03MB167FE14DFB49FB4251C503F904A0@BLUPR03MB167.namprd03.prod.outlook.com>
 (Pankaj Chauhan's message of "Mon, 19 Jan 2015 12:27:04 +0000")
References: <BLUPR03MB167FE14DFB49FB4251C503F904A0@BLUPR03MB167.namprd03.prod.outlook.com>
Message-ID: <87fvb6hpr0.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19 2015 at 12:27:04 pm GMT, Pankaj Chauhan <Pankaj.Chauhan@freescale.com> wrote:
> Hello,
>
> I have a small query regarding machine_restart() for ARM64.
>
> For both ARM64 and ARM32 machine_restart()
> (arch/arm*/kernel/process.c) calls arm_pm_restart, for doing machine
> specific restart. For ARM32 arm_pm_restart, gets initialized by
> 'machine_desc.restart' provided by each machine/platform
> implementation.
>
> For ARM64 how are different platforms supposed to initialize
> arm_pm_restart pointer?  (As there is no struct machine_desc defined
> for ARM64). Is there a framework similar to machine_desc for setting
> up the restart handlers?

Have a look at the stuff implemented in drivers/power/reset. The main
idea is to use a restart notifier, which works for both 32 and 64bit
kernels.

	M.
-- 
Jazz is not dead. It just smells funny.
