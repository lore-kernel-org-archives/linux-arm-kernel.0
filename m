From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Feb 2017 14:44:16 +0100
Subject: [PATCH 3/8] mm: cma: Export a few symbols
In-Reply-To: <20170209192046.GB31906@dhcp22.suse.cz>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <2dee6c0baaf08e2c7d48ceb7e97e511c914d0f87.1486655917.git-series.maxime.ripard@free-electrons.com>
 <20170209192046.GB31906@dhcp22.suse.cz>
Message-ID: <20170213134416.akgmtv3lv5m65fwx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Thu, Feb 09, 2017 at 08:20:47PM +0100, Michal Hocko wrote:
> [CC CMA people]
> 
> On Thu 09-02-17 17:39:17, Maxime Ripard wrote:
> > Modules might want to check their CMA pool size and address for debugging
> > and / or have additional checks.
> > 
> > The obvious way to do this would be through dev_get_cma_area and
> > cma_get_base and cma_get_size, that are currently not exported, which
> > results in a build failure.
> > 
> > Export them to prevent such a failure.
> 
> Who actually uses those exports. None of the follow up patches does
> AFAICS.

This is for the ARM Mali GPU driver that is out of tree, unfortunately.

In one case (using the legacy fbdev API), the driver wants to (and
probably should) validate that the buffer as indeed been allocated
from the memory allocation pool.

Rob suggested that instead of hardcoding it to cover the whole RAM
(which defeats the purpose of that check in the first place), we used
the memory-region bindings in the DT and follow that, which does work
great, but we still have to retrieve the base address and size of that
region, hence why this patches are needed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/f5f36496/attachment.sig>
