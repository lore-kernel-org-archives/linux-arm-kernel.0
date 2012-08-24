From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 24 Aug 2012 19:20:30 +0300
Subject: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
In-Reply-To: <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
Message-ID: <5037A9CE.1080809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 08/24/2012 06:38 PM, Paul Walmsley wrote:
> Do we need both this one and your '[PATCH] driver core: Check if r->name 
> is valid in platform_get_resource_byname()' ?  Or would that second patch 
> be enough?  Is the crash happening in the platform_get_resource_byname() 
> iterator?

The crash happens in platform_get_resource_byname(). What I see as a problem
that when we boot without DT the r->name is configured for the hwmods. If we
boot with DT we discard the resources created by the OF (which also have the
r->name configured). We replace the resources from hwmods but we do not fix up
the resource names (which is done in other cases).
I have sent the patch for the drivers core as well since I think it is a good
practice anyway to check for NULL pointer before strcmp().

Either is good, but IMHO we should fix this in omap_hwmod (at least).

-- 
P?ter
