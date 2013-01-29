From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 29 Jan 2013 09:42:39 +0000
Subject: [PATCH v2 1/4] ARM: OMAP2+: dpll: round rate to closest value
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
References: <cover.1358937533.git.afzal@ti.com>
 <871e6890897534b6c3669e252f23bef5ff1247b6.1358937533.git.afzal@ti.com>
 <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA94FDD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Jan 25, 2013 at 17:48:22, Mohammed, Afzal wrote:
> On Fri, Jan 25, 2013 at 13:48:11, Paul Walmsley wrote:

> > like MPU CPUFreq.  I'd suggest reverting 
> > 241d3a8dca239610d3d991bf58d4fe38c2d86fd5 or using a similar approach.

> As you prefer reverting the above commit, I will proceed so, hmm.. got

This patch or reverting the above mentioned commit is not required for
lcdc to be usable on am335x, instead please consider for inclusion
patches 3 & 4 of this series,

"ARM: OMAP2+: clock: DEFINE_STRUCT_CLK_FLAGS helper" and
"ARM: AM33XX: clock: SET_RATE_PARENT in lcd path"

Patches 3 & 4 are required to have a functional frame buffer driver
on am335x, also it may help drm driver for the lcdc ip in am335x to
be a platform independent one.

Regards
Afzal
