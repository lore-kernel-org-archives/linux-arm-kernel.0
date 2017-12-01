From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 01 Dec 2017 18:22:11 +0100
Subject: [PATCH v3 0/4] Fixes for omapdrm on OpenPandora and GTA04
In-Reply-To: <27b12bc8-2c3a-6caa-c800-158b75f80d3f@ti.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <CGME20171130105533epcas3p1839ccb7df2896e613f739e7f07a31f03@epcas3p1.samsung.com>
 <27b12bc8-2c3a-6caa-c800-158b75f80d3f@ti.com>
Message-ID: <8663745.l6RXqWc6WO@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 30, 2017 12:54:07 PM Tomi Valkeinen wrote:
> On 28/11/17 17:48, H. Nikolaus Schaller wrote:
> > Changes V3:
> > * stay compatible with old DTB files which still use "toppoly" (suggested by Tomi Valkeinen)
> > * replaced MODULE_ALIAS entries by MODULE_DEVICE_TABLE (suggested by Andrew F. Davis)
> > * removed DSI VDDS patch as it has already been accepted
> > 
> > 2017-11-16 09:50:22: Changes V2:
> > * replaced patch to fix DSI VDDS for OMAP3 by equivalent patch from Laurent Pinchart
> > * keep previous compatibility option in panel driver to handle older device tree binaries
> > 
> > 2017-11-08 22:09:36:
> > This patch set fixes vendor names of the panels
> > and fixes a problem on omapdrm with enabling
> > VDD_DSI for OMAP3 which is needed for displaying
> > the Red and Green channel on OMAP3530 (Pandora).
> > 
> > H. Nikolaus Schaller (4):
> >   omapdrm: panel: fix compatible vendor string for td028ttec1
> >   omapdrm: panel: td028ttec1: replace MODULE_ALIAS by
> >     MODULE_DEVICE_TABLE
> >   DTS: GTA04: fix panel compatibility string
> >   DTS: Pandora: fix panel compatibility string
> > 
> >  .../panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}    |  4 ++--
> >  arch/arm/boot/dts/omap3-gta04.dtsi                          |  2 +-
> >  arch/arm/boot/dts/omap3-pandora-common.dtsi                 |  2 +-
> >  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c     | 13 ++++++++++++-
> >  .../fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 12 +++++++++++-
> >  5 files changed, 27 insertions(+), 6 deletions(-)
> >  rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)
> > 
> 
> Thanks. I have picked up patches 1 and 2.

Thanks for taking care of them (they both look fine to me).

> 3 can be applied when 1 & 2 are in. The change in 4 could be applied
> independently, but it conflicts with 3.
> 
> Tony, how do you want to handle 3 and 4? I will push 1 and 2 to v4.16. I
> don't think they are real issues, so I don't see a reason to push them
> as fixes to v4.15. I think they are mostly just cleanups, and we might
> as well wait until v4.17, but that's quite far away...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
