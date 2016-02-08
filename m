From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 8 Feb 2016 09:03:36 -0300
Subject: [PATCH] drm/exynos: dp: Fix panel and bridge lookup logic
In-Reply-To: <1454080171-23769-1-git-send-email-javier@osg.samsung.com>
References: <1454080171-23769-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56B88418.7090106@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Inki,

On 01/29/2016 12:09 PM, Javier Martinez Canillas wrote:
> Commit a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support
> for panel") made the Exynos DP DT binding more consistent since the OF
> graph could be used to lookup either a panel or a bridge device node.
>
> Before that commit, a panel would be looked up using a phandle and a
> bridge using the OF graph which made the DT binding not consistent.
>
> But the patch broke the later case since not finding a panel dev node
> would cause the driver's to do a probe deferral instead of attempting
> to lookup a bridge device node associated with the remote endpoint.
>
> So instead of returning a -EPROBE_DEFER if a panel is not found, check
> if there's a bridge and only do a probe deferral if both aren't found.
>
> Fixes: a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support for panel")
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>

Any comments about this patch? It is needed to have display working on
machines with a bridge chip again so it should be pushed to -rc ASAP.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
