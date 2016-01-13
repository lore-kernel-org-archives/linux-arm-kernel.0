From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 13 Jan 2016 11:39:15 +0800
Subject: [PATCH v2 2/6] dt-bindings: ARM: Mediatek: Document bindings
 for MT2701
In-Reply-To: <20160106150800.GA941@rob-hp-laptop>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451975422-31174-3-git-send-email-jamesjj.liao@mediatek.com>
 <20160106150800.GA941@rob-hp-laptop>
Message-ID: <1452656355.2657.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, 2016-01-06 at 09:08 -0600, Rob Herring wrote:
> On Tue, Jan 05, 2016 at 02:30:18PM +0800, James Liao wrote:
> > This patch adds the binding documentation for apmixedsys, bdpsys,
> > ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
> > vdecsys for Mediatek MT2701.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> 
> [...]
> 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> > new file mode 100644
> > index 0000000..4137196
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> > @@ -0,0 +1,22 @@
> > +Mediatek bdpsys controller
> > +============================
> > +
> > +The Mediatek bdpsys controller provides various clocks to the system.
> > +
> > +Required Properties:
> > +
> > +- compatible: Should be:
> > +	- "mediatek,mt2701-bdpsys", "syscon"
> 
> If this block and others only provide clocks, then why do you need 
> syscon here? If it is more that clocks, then the description is wrong.

Sorry for late reply.

In bdpsys and other similar subsystems, clock controlling and other
feature controlling share the same register space. That means we may
have multiple DT nodes with the same reg (register address) property.
But it's not a good idea because we may have racing issue when multiple
drivers share the same register space. With syscon, drivers that need
share the same register base with bdpsys can safely control registers
through regmap APIs.

These subsystem nodes described in arm/mediatek/ are clock controllers,
some of them may be the reset controller at the same time. Other
subsystem features will have their own DT nodes and share the same
register space by referring to these clock controllers.


Best regards,

James
