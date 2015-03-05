From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 5 Mar 2015 18:16:32 +0000 (UTC)
Subject: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
In-Reply-To: <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
 <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
Message-ID: <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Mar 2015, Dave Gerlach wrote:

> Introduce a dt property, ti,no-init, that prevents hwmod initialization.
> Even if a dt node is marked as disabled, hwmod still at least enables
> the hwmod and programs the sysconfig before attempting to idle it at
> boot. If an IP has been disabled by the hardware configuration on a
> platform, this will cause a hang due to writing to inactive registers.
> This property prevents that from happening by marking the hwmod as
> _HWMOD_STATE_DISABLED during init.

I'm kind of wondering if hwmod should even touch a device if it's marked 
as disabled in the DT.  Tony, what do you think?


- Paul
