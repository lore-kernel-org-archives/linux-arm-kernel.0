From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 14:23:45 -0700 (MST)
Subject: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after dss_core
In-Reply-To: <1325028693-14728-1-git-send-email-yanok@emcraft.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
 <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Message-ID: <alpine.DEB.2.00.1201251423290.5324@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Dec 2011, Ilya Yanok wrote:

> dss_core has to be initialized before any other DSS hwmod. Currently
> this is broken as dss_core is listed in chip/revision specific hwmod
> lists while other DSS hwmods are listed in common list which is
> registered first.
> 
> This patch moves DSS hwmods (except for dss_core) to the separate list
> which is registered last to ensure that dss_core is already registered.
> 
> This solves the problem with BUG() in L3 interrupt handler on boards
> with DSS enabled in bootloader.
> 
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Archit Taneja <archit@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Thanks Ilya, queued for 3.3-rc.


- Paul
