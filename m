From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 7 Jun 2016 09:49:33 +0100
Subject: [PATCH 1/2] ARM: dts: exynos: Fix port nodes names for Exynos5250
 Snow board
In-Reply-To: <1465244684-23612-2-git-send-email-javier@osg.samsung.com>
References: <1465244684-23612-1-git-send-email-javier@osg.samsung.com>
 <1465244684-23612-2-git-send-email-javier@osg.samsung.com>
Message-ID: <57568A9D.7080804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/16 21:24, Javier Martinez Canillas wrote:
> Commit 5c9cbade0629 ("ARM: dts: exynos: Fix DTC unit name warnings in
> Exynos5250") fixed all the DTC warnings about mismatchs between unit
> names and reg properties in Exynos5250 boards DTS.
> 
> But unfortunately it also added a regression on the Exynos5250 Snow
> Chromebook when changing the port node names since the OF graph logic
> expects the port nodes to be always named 'port'.
> 
> The Documentation/devicetree/bindings/graph.txt binding document says
> that when there is more than one port, '#address-cells', '#size-cells'
> and 'reg' properties should be used to number the port nodes.
> 
> Fixes: 5c9cbade0629 ("ARM: dts: exynos: Fix DTC unit name warnings in Exynos5250")
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

I've tested this on top of -rc1, and it indeed fixes the display
initialization I was seeing. It then dies in a horrible way, but that's
a separate bug.

So for this patch:

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
