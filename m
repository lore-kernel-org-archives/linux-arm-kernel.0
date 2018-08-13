From: owen.chen@mediatek.com (Owen Chen)
Date: Mon, 13 Aug 2018 17:12:03 +0800
Subject: [PATCH v5 01/11] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
In-Reply-To: <20180720174331.GA26945@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-2-git-send-email-mars.cheng@mediatek.com>
 <20180720174331.GA26945@rob-hp-laptop>
Message-ID: <1534151523.17494.48.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-07-20 at 11:43 -0600, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 04:52:22PM +0800, Mars Cheng wrote:
> > This patch adds the binding documentation for apmixedsys, audsys, camsys,
> > imgsys, infracfg, mipi0a, topckgen, vcodecsys
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
> >  .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
> >  .../bindings/arm/mediatek/mediatek,camsys.txt      |   27 ++++++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
> >  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
> >  .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   23 +++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
> >  .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
> >  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
> >  .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   22 ++++++++++++++++
> >  10 files changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > index b404d59..44eaeac 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > @@ -8,6 +8,7 @@ Required Properties:
> >  - compatible: Should be one of:
> >  	- "mediatek,mt2701-apmixedsys"
> >  	- "mediatek,mt2712-apmixedsys", "syscon"
> > +	- "mediatek,mt6765-apmixedsys", "syscon"
> >  	- "mediatek,mt6797-apmixedsys"
> >  	- "mediatek,mt7622-apmixedsys"
> >  	- "mediatek,mt8135-apmixedsys"
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > index 34a69ba..9a8672a 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > @@ -7,6 +7,7 @@ Required Properties:
> >  
> >  - compatible: Should be one of:
> >  	- "mediatek,mt2701-audsys", "syscon"
> > +	- "mediatek,mt6765-audsys", "syscon"
> >  	- "mediatek,mt7622-audsys", "syscon"
> >  - #clock-cells: Must be 1
> >  
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> > new file mode 100644
> > index 0000000..dc75783
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> > @@ -0,0 +1,27 @@
> > +MediaTek CAMSYS controller
> > +============================
> > +
> > +The MediaTek CAMSYS controller provides various clocks to the system.
> 
> Only clocks? If so, then this should be moved to bindings/clocks/.
> 

camsys conclude not only clks but also mtcmos, so it's better to put
this node in this path.

> > +
> > +Required Properties:
> > +
> > +- compatible: Should be one of:
> > +	- "mediatek,mt6765-camsys", "syscon"
> > +- #clock-cells: Must be 1
> > +
> > +The AUDSYS controller uses the common clk binding from
> > +Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> > +
> > +Required sub-nodes:
> > +-------
> > +For common binding part and usage, refer to
> > +../sonud/mt2701-afe-pcm.txt.
> > +
> > +Example:
> > +
> > +camsys: camsys at 1a000000  {
> 
> clock-controller at ...
> 
> if the above answer is yes.
> 
> Same comments on the other docs.
