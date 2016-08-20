From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 20 Aug 2016 18:03:07 +0200
Subject: [RFC 00/17] clk: Add per-controller locks to fix deadlocks
In-Reply-To: <8519a1cf-ec51-2914-e4aa-27b26b9233de@osg.samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
 <8519a1cf-ec51-2914-e4aa-27b26b9233de@osg.samsung.com>
Message-ID: <20160820160307.GB6344@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 03:31:08PM -0400, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 08/16/2016 09:34 AM, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > RFC, please, do not apply, maybe except patch #1 which is harmless.
> > 
> > 
> > Introduction
> > ============
> > The patchset brings new entity: clock controller representing a hardware
> > block.  The clock controller comes with its own prepare lock which
> > is used then in many places.  The idea is to fix the deadlock mentioned
> > in commit 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping
> > I2C clock prepared") and commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock
> > by keeping clock prepared").
> > 
> > 
> 
> I'm not familiar enough with the common clock framework to do a proper review
> of this patch-set, but I've tested both on an Exynos5800 Peach Pi Chromebook
> and an Exynos5422 Odroid XU4 board and I didn't find any clock regressions.
> 
> Also, I confirmed that the possible deadlock in the Odroid XU4 that was fixed
> by reverted commit 10ff4c5239a1 doesn't happen anymore with your patches.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks for testing, I appreciate that!

Best regards,
Krzysztof
