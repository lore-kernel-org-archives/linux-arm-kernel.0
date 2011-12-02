From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 13:02:42 +0000
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <4ED8C57B.2000503@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
 <4ED8C57B.2000503@ti.com>
Message-ID: <20111202130242.GO8245@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 02:32:59PM +0200, Peter Ujfalusi wrote:

> As of now we receive all these information via OMAP hwmod.
> All the properties (addresses, irq, etc) of the HW IP will be coming
> from DT as soon as I can remove the ti,hwmod property.

Oh, right.  We should really be churning the device tree like this - the
idea is that the device tree should be stable and independant of kernel
versions.  It would be better if we were able to go straight to the one
without hwmod, especially if Benoit is able to get the underlying
changes done soon (which sounded like it might be the case).  Could we
define and implement the "real" version now (it should be reasonable to
code blind except possibly for the DMA channel as it's such a direct
mapping) with hwmod left in there as something that's legacy for old
kernels?
