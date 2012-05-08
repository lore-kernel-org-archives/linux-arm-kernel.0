From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 May 2012 13:44:56 -0700
Subject: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
 <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87wr4mmmgn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Define a CPU_IDLE section in the makefile, declare the functions in
> the header files conforming to the kernel coding rules and remove the
> 'define's in the C files.
>
> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle drivers
> use some functions from the pm subsystem.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>

The changelog doesn't really answer "why" this change is needed.  IOW, I
don't understand from the changelog exactly what problem this patch is
trying to solve.

AFAICT, it's just shuffling around the dependencies, and changes the
omap*_idle_init() calls into inline nops instead of function call nops.

Kevin
