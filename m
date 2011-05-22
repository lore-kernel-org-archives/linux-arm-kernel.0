From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 May 2011 13:17:17 +0200
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <4DD8F177.9020809@ti.com>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<1306055080-30420-2-git-send-email-plagnioj@jcrosoft.com>
	<201105221154.28211.arnd@arndb.de> <4DD8F177.9020809@ti.com>
Message-ID: <20110522111717.GD15292@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:50 Sun 22 May     , Santosh Shilimkar wrote:
> On 5/22/2011 3:24 PM, Arnd Bergmann wrote:
> >On Sunday 22 May 2011 11:04:40 Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>
> >>--- a/arch/arm/plat-omap/io.c
> >>+++ b/arch/arm/plat-omap/io.c
> >>@@ -23,6 +23,12 @@
> >>  #define BETWEEN(p,st,sz)       ((p)>= (st)&&  (p)<  ((st) + (sz)))
> >>  #define XLATE(p,pst,vst)       ((void __iomem *)((p) - (pst) + (vst)))
> >>
> >>+void __init omap_set_ioremap(void)
> >>+{
> >>+       arch_ioremap = omap_ioremap;
> >>+       arch_iounmap = omap_iounmap;
> >>+}
> >>+
> >>  /*
> >>   * Intercept ioremap() requests for addresses in our fixed mapping regions.
> >
> >The only thing that the ioremap functions for omap do as a special case
> >is to handle the fixed mappings. Maybe a better approach would be to
> >make handling this in omap (and others) unnecessary, using one of
> >two approaches:
> >
> >* Remove all fixed mappings that are also ioremapped, and rely on every
> >   user calling ioremap correctly. I don't see why we would want to allow
> >   both methods anyway.
> >
> What do you mean by "Remove all fixed mappings that are also
> ioremapped" ?
> Why will you ioremap() it again if the fixed mapping is already
> registered through iotable_init()
agreed on this

Best Regards,
J.
