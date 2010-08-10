From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 23:14:33 +0100
Subject: [PATCH] ARM: fix syntax error in main Kconfig file
In-Reply-To: <1281471252-31424-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100810200718.GA26031@pengutronix.de>
	<1281471252-31424-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100810221433.GE7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 10:14:12PM +0200, Uwe Kleine-K?nig wrote:
> -	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
> +	select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\

This is still crap.  '\\' on the end of the line...

And no surprises that I'm getting conflicts when merging my master and
devel branches here.  Don't bother submitting a new patch, I'll fix it
in the conflict resolution.
