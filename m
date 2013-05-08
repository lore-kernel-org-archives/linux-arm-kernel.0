From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 May 2013 09:48:10 +0200
Subject: [PATCH] ARM: imx: compile fix for hotplug.c
In-Reply-To: <1367474331-3479-1-git-send-email-shawn.guo@linaro.org>
References: <1367474331-3479-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130508074810.GN23285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, May 02, 2013 at 01:58:51PM +0800, Shawn Guo wrote:
> Commit bca7a5a (ARM: cpu hotplug: remove majority of cache flushing
> from platforms) removes include of <asm/cacheflush.h> and hence
> discovers a few indirect inclusion and declaration problems as below.
> 
>   CC      arch/arm/mach-imx/hotplug.o
> In file included from arch/arm/mach-imx/hotplug.c:16:0:
> arch/arm/mach-imx/common.h:100:29: warning: ?struct pt_regs? declared inside parameter list [enabled by default]
> arch/arm/mach-imx/common.h:100:29: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> arch/arm/mach-imx/common.h:101:29: warning: ?struct pt_regs? declared inside parameter list [enabled by default]
> arch/arm/mach-imx/hotplug.c: In function ?imx_cpu_die?:
> arch/arm/mach-imx/hotplug.c:53:2: error: implicit declaration of function ?cpu_do_idle? [-Werror=implicit-function-declaration]
> arch/arm/mach-imx/hotplug.c: In function ?imx_cpu_kill?:
> arch/arm/mach-imx/hotplug.c:58:26: error: ?jiffies? undeclared (first use in this function)
> arch/arm/mach-imx/hotplug.c:58:26: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/mach-imx/hotplug.c:58:2: error: implicit declaration of function ?msecs_to_jiffies? [-Werror=implicit-function-declaration]
> arch/arm/mach-imx/hotplug.c:61:3: error: implicit declaration of function ?time_after? [-Werror=implicit-function-declaration]
> 
> Fix them by adding the needed inclusion and declaration.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
I just sent an equivalent patch for that issue (so:
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
).

Is this patch already queued somewhere?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
