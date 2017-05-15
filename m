From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 15 May 2017 17:19:35 +0800
Subject: [PATCH v3 3/9] dt-bindings: arm: mediatek: update for MT7623n
 SoC and relevant boards
In-Reply-To: <33b3a8a3-006b-91b3-e30d-56518fb9ae7a@gmail.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
 <e8f5dc8578c3980ac9c6411ad7fae1c8d747f567.1494574682.git.sean.wang@mediatek.com>
 <33b3a8a3-006b-91b3-e30d-56518fb9ae7a@gmail.com>
Message-ID: <1494839975.10505.24.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Appreciate your help on reviewing. Add my comments inline


On Mon, 2017-05-15 at 09:53 +0200, Matthias Brugger wrote:
> 
> On 12/05/17 09:56, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Because there are two versions of MT7623 SoC that is MT7623a and MT7623n
> > respectively. So update the part of MT7623n bindings to allow that people
> > tend to differentiate which MT7623 SoC the boards applies.
> > 
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/arm/mediatek.txt | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> > index c860b24..0924b62 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> > @@ -1,6 +1,6 @@
> >   MediaTek mt65xx, mt67xx & mt81xx Platforms Device Tree Bindings
> >   
> > -Boards with a MediaTek mt65xx/mt67xx/mt81xx SoC shall have the
> > +Boards with a MediaTek mt65xx/mt67xx/mt762x/mt81xx SoC shall have the
> >   following property:
> >   
> >   Required root node property:
> > @@ -12,7 +12,7 @@ compatible: Must contain one of
> >      "mediatek,mt6592"
> >      "mediatek,mt6755"
> >      "mediatek,mt6795"
> > -   "mediatek,mt7623"
> > +   "mediatek,mt7623" which is referred to MT7623N SoC
> >      "mediatek,mt8127"
> >      "mediatek,mt8135"
> >      "mediatek,mt8173"
> > @@ -38,9 +38,9 @@ Supported boards:
> >   - Evaluation board for MT6795(Helio X10):
> >       Required root node properties:
> >         - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
> > -- Evaluation board for MT7623:
> > +- Reference  board for MT7623n with NAND:
> >       Required root node properties:
> > -      - compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
> > +      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
> 
> Please explain in the commit message why you change this binding and why 
> this is not problematic. Either in this patch or add a new one.
> 
I will add more description for why changing binding here in the commit
message of the patch. 

"mediatek,mt7623-evb" can be safely changed to
"mediatek,mt7623n-rfb-nand" because real users can't get the board that
is a kind of debug board internally in Mediatek. Instead We should add
more specific board variants as the adding here to let people easily
know what board they uses. 

The similar description is done as (2/9) arm: dts: mt7623: rename
mt7623-evb.dts to arch/arm/boot/dts/mt7623n-rfb.dtsi that states
" Additionally Mediatek pointed out, that the EVB is yet another board
and the board in question is infact the RFB. Take this into account
while renaming the files." 

However I didn't make similar sufficient statements into the patch when
I split from the last version of the patch. Sorry:(


> For convenience for the device-tree maintainer, add the binding patches 
> at the beginning of your patch list. It makes their life easier and a 
> review faster, a clear win-win situation :)
> 

Okay. thanks for the suggestion:) 
I will reorder them to help direct them to the part they're interested
in.

> Thanks,
> Matthias
> 
> >   - MTK mt8127 tablet moose EVB:
> >       Required root node properties:
> >         - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
> > 
