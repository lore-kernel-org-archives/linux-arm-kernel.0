From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 10:44:26 +0530
Subject: [PATCH 14/30] ARM: omap2: irq.c is always needed
In-Reply-To: <1317566760-25681-15-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-15-git-send-email-arnd@arndb.de>
Message-ID: <4E8944B2.4020700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> The Makefile only includes irq.o for omap2 and omap3, but it's in
> fact also required to build omap4-only kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
That should not be the case. Why do you think it is needed for OMAP4 ?
There is nothing in this file which OMAP4 needs since it makes
use of GIC and wakeupgen for it's interrupt handling.


Regards
Santosh
