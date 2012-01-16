From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 16:54:22 +0000
Subject: [PATCH] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <1326732555-17915-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1326732555-17915-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120116165422.GC32049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 05:49:15PM +0100, Uwe Kleine-K?nig wrote:
> cr_alignment is defined in arch/arm/kernel/entry-armv.S. When a build
> doesn't include this file but arch/arm/kernel/head-common.S the latter
> intruduces an invalid reference to cr_alignment.
> 
> So handle cr_alignment not being available in head-common.S and for
> completeness only define and use cr_alignment (and cr_no_alignment) when
> CONFIG_CPU_CP15 is enabled.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> currently arch/arm/kernel/entry-armv.S is used unconditionally, but the
> Cortex-M3 port in my tree doesn't need it. So this patch fixex a build
> error only in my tree and it's not urgent to include it.

We'll wait then until we can see what you're replacing that file with.
