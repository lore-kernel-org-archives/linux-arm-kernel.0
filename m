From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 26 May 2015 16:55:36 +0800
Subject: [PATCH 3/5] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <20150526075643.GF6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-4-git-send-email-jamesjj.liao@mediatek.com>
 <20150526075643.GF6325@pengutronix.de>
Message-ID: <1432630536.15597.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, 2015-05-26 at 09:56 +0200, Sascha Hauer wrote:
> On Thu, May 21, 2015 at 03:12:54PM +0800, James Liao wrote:
> > This adds the binding documentation for the mmsys, imgsys, vdecsys,
> > vencsys and vencltsys controllers found on Mediatek SoCs.
> > 
> > index 0000000..a5b94a7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
> 
> Do these really become multiple drivers so that it's worth abstracting
> them in the clock framework?

These clocks need to be controlled among several drivers. For example,
vdecsys clocks will be controlled by VDEC driver (not ready yet) and
MT8173 SMI driver [1]. That means these clocks need a mechanism to share
between these 2 drivers. CCF share clocks by using of reference count,
so I think it's suitable to implement these subsystem clocks.

As I know SMI driver need to access clocks among mmsys, imgsys, vdecsys,
vencsys and vencltsys. So in this patch I added clocks of these
subsystems into CCF.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html


Best regards,

James
