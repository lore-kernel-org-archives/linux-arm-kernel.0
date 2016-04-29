From: airlied@linux.ie (Dave Airlie)
Date: Fri, 29 Apr 2016 06:08:05 +0100 (IST)
Subject: [PATCH] memory: mtk-smi: export mtk_smi_larb_get/put
In-Reply-To: <1461769507.4044.50.camel@pengutronix.de>
References: <1461747086-26286-1-git-send-email-p.zabel@pengutronix.de>
 <57209DD0.5050002@gmail.com> <1461759758.4044.43.camel@pengutronix.de>
 <5720BAF6.1070808@gmail.com> <1461769507.4044.50.camel@pengutronix.de>
Message-ID: <alpine.DEB.2.00.1604290607540.7793@skynet.skynet.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Am Mittwoch, den 27.04.2016, 15:13 +0200 schrieb Matthias Brugger:
> > 
> > On 27/04/16 14:22, Philipp Zabel wrote:
> > > Hi Matthias,
> > >
> > > Am Mittwoch, den 27.04.2016, 13:09 +0200 schrieb Matthias Brugger:
> > >> Hi Philipp,
> > >>
> > >> On 27/04/16 10:51, Philipp Zabel wrote:
> > >>> To allow building mediatek-drm.ko as a module, the
> > >>> mtk_smi_larb_get and mtk_smi_larb_put symbols have
> > >>> to be exported.
> > >>>
> > >>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > >>> ---
> > >>>    drivers/memory/mtk-smi.c | 2 ++
> > >>>    1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > >>> index 089091f..f6b5757 100644
> > >>> --- a/drivers/memory/mtk-smi.c
> > >>> +++ b/drivers/memory/mtk-smi.c
> > >>> @@ -91,6 +91,7 @@ int mtk_smi_larb_get(struct device *larbdev)
> > >>>
> > >>>    	return 0;
> > >>>    }
> > >>> +EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
> > >>>
> > >>>    void mtk_smi_larb_put(struct device *larbdev)
> > >>>    {
> > >>> @@ -106,6 +107,7 @@ void mtk_smi_larb_put(struct device *larbdev)
> > >>>    	mtk_smi_disable(&larb->smi);
> > >>>    	mtk_smi_disable(common);
> > >>>    }
> > >>> +EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
> > >>>
> > >>>    static int
> > >>>    mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
> > >>>
> > >>
> > >> Strangely this didn't work with my config (attached).
> > >> Would you mind to double check?
> > >
> > > warning: (DRM_MEDIATEK && MTK_IOMMU) selects MTK_SMI which has unmet
> > > direct dependencies (MEMORY && (ARCH_MEDIATEK || COMPILE_TEST))
> > >
> > > I suppose DRM_MEDIATEK also has to select MEMORY, just like MTK_IOMMU
> > > does?
> > >
> > 
> > Yes that's it.
> > 
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > 
> > Dave, can you take this patch through your tree to avoid build breakage?
> > 
> > Thanks,
> > Matthias
> 
> Should I include this patch in the next MT8173 DRM pull request?

Yes please do.

Dave.
