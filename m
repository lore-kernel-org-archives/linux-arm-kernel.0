From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 1 May 2017 15:06:45 +0800
Subject: [PATCH v2 25/30] arm: dts: mt7623: rename mt7623-evb.dts to
 arch/arm/boot/dts/mt7623n-rfb.dtsi
In-Reply-To: <20170428203025.gdrtbudfzwy5z4h5@rob-hp-laptop>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-26-git-send-email-sean.wang@mediatek.com>
 <20170428203025.gdrtbudfzwy5z4h5@rob-hp-laptop>
Message-ID: <1493622405.32195.20.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-04-28 at 15:30 -0500, Rob Herring wrote:
> On Wed, Apr 26, 2017 at 05:26:09PM +0800, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > There are 2 versions of the SoC. MT7623N is almost identical to MT7623A
> > but has some additional multimedia features. The reference boards are
> > available as NAND or MMC and might have a different ethernet setup. In
> > order to reduce the duplication of devicetree code we add an intermediate
> > dtsi file for these reference boards. Additionally Mediatek pointed out,
> > that the EVB is yet another board and the board in question is infact the
> > RFB. Take this into account while renaming the files.
> 
> You are breaking compatibility with existing DTs. Just document which 
> flavor you want "mediatek,mt7623" to refer to and add the new one. Or 
> just add 2 new strings but keep the old one.
> 

Hi Rob,

really appreciate your patient guidance.

I prefer to using the way one you suggest: the old one is kept and
refers to mt7623n SoC and new one will be added for mt7623a Soc.

	Sean

> > 
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > 
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt |  6 ++--
> >  arch/arm/boot/dts/Makefile                         |  2 +-
> >  arch/arm/boot/dts/mt7623-evb.dts                   | 33 ----------------------
> >  arch/arm/boot/dts/mt7623n-rfb-nand.dts             | 21 ++++++++++++++
> >  arch/arm/boot/dts/mt7623n-rfb.dtsi                 | 29 +++++++++++++++++++
> >  arch/arm/mach-mediatek/mediatek.c                  |  4 +--
> >  arch/arm/mach-mediatek/platsmp.c                   |  2 +-
> >  7 files changed, 57 insertions(+), 40 deletions(-)
> >  delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
> >  create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
> >  create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> > index c860b24..7f7c804 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> > @@ -12,7 +12,7 @@ compatible: Must contain one of
> >     "mediatek,mt6592"
> >     "mediatek,mt6755"
> >     "mediatek,mt6795"
> > -   "mediatek,mt7623"
> > +   "mediatek,mt7623n"
> >     "mediatek,mt8127"
> >     "mediatek,mt8135"
> >     "mediatek,mt8173"
