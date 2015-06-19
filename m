From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 19 Jun 2015 16:36:06 +0200
Subject: [PATCH] GPU: ipu: fix lockup caused by pending chained interrupts
In-Reply-To: <E1Z4zMT-0004Y7-KJ@rmk-PC.arm.linux.org.uk>
References: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
 <E1Z4zMT-0004Y7-KJ@rmk-PC.arm.linux.org.uk>
Message-ID: <1434724566.3039.50.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 16.06.2015, 23:29 +0100 schrieb Russell King:
> Even with the oops fixed by a previous patch, the system still fails to
> kexec, due to a stuck chained interrupt locking the system.  We must
> disable the child interrupts prior to setting up the irq chip to ensure
> we don't get stuck here.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thank you.

> Maybe this is all that's really needed... would also be nice if this
> path had an etry in MAINTAINERS...

I'll send a patch to add it to the imx-drm driver section.

regards
Philipp
