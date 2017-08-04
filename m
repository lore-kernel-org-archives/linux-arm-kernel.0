From: guochun.mao@mediatek.com (Guochun Mao)
Date: Fri, 4 Aug 2017 11:44:10 +0800
Subject: [PATCH] dt-bindings: mtd: add new compatible strings for mtk
 nor controller
In-Reply-To: <20170803174750.bipdynhyyyozzjk6@rob-hp-laptop>
References: <1500948617-19627-1-git-send-email-guochun.mao@mediatek.com>
 <1500948617-19627-2-git-send-email-guochun.mao@mediatek.com>
 <03016ea3-51ad-0b2d-e824-0a20913bd7c1@gmail.com>
 <20170802103637.16cd6548@bbrezillon>
 <535cc2d5-7bc9-2cb7-42cf-9d7058e64226@wedev4u.fr>
 <1501726602.4381.23.camel@mhfsdcap03>
 <20170803174750.bipdynhyyyozzjk6@rob-hp-laptop>
Message-ID: <1501818250.4381.26.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-08-03 at 12:47 -0500, Rob Herring wrote:
> On Thu, Aug 03, 2017 at 10:16:42AM +0800, Guochun Mao wrote:
> > Hi Cyrille,
> > 
> > On Wed, 2017-08-02 at 17:31 +0200, Cyrille Pitchen wrote:
> > > Hi Guochun,
> > > 
> > > Le 02/08/2017 ? 10:36, Boris Brezillon a ?crit :
> > > > Hi Matthias,
> > > > 
> > > > On Tue, 1 Aug 2017 14:33:22 +0200
> > > > Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > > > 
> > > >> On 07/25/2017 04:10 AM, Guochun Mao wrote:
> > > >>> Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
> > > >>> for nor flash node's compatible strings.
> > > >>>
> > > >>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > >>> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> > > >>> ---
> > > >>>   .../devicetree/bindings/mtd/mtk-quadspi.txt        |    2 ++
> > > >>>   1 file changed, 2 insertions(+)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > > >>> index 5ded66a..9845ff4 100644
> > > >>> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > > >>> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > > >>> @@ -3,6 +3,8 @@
> > > >>>   Required properties:
> > > >>>   - compatible: 	  The possible values are:
> > > >>>   		  "mediatek,mt2701-nor"
> > > >>> +		  "mediatek,mt2712-nor"
> > > >>> +		  "mediatek,mt7622-nor"
> > > >>>   		  "mediatek,mt7623-nor"
> > > >>>   		  "mediatek,mt8173-nor"
> > > >>>   		  For mt8173, compatible should be "mediatek,mt8173-nor".
> > > >>>
> > > 
> > > There should be another patch to update the mtk_nor_of_ids[] array in
> > > the mtk-quadspi.c driver, shouldn't it?
> > > 
> > > Currently, I only see the "mediatek,mt8173-nor" compatible string at the
> > > driver side. The driver and its documentation should be aligned and both
> > > patches should be applied at the same time.
> > 
> > > Best regards,
> > > 
> > > Cyrille
> > 
> > 
> > From my designer's info, these IPs' nor controller could use same
> > driver, and I had verified it. I think there's no need to update
> > mtk_nor_of_ids[], unless we find difference between these IPs(exactly
> > compared with mt8173).
> > How do you think?
> 
> That is perfectly fine, but then the documentation needs to be explicit 
> as to what are the fallback compatibles. It's one valid combination per 
> line, not 1 compatible string per line.

OK, I'll corret the description in next version.
Thanks a lot.

Guochun


> 
> Rob
> 
> > 
> > And, we will add dts patches for new SOCs, are these patches should
> > applied with this documentation?
> > 
> > Best regards,
> > Guochun
> > 
