From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Tue, 23 May 2017 11:35:57 +0800
Subject: [PATCH v3 0/3] Fix mdp device tree
In-Reply-To: <fe23cd68-461d-845a-13e9-93dd9493c1f9@xs4all.nl>
References: <1494559361-42835-1-git-send-email-minghsiu.tsai@mediatek.com>
 <20ba4f83-7d22-2a8e-4eb6-7d4eba92e2ae@xs4all.nl>
 <1f7de9e7-2c18-6662-4b95-519d22a70723@gmail.com>
 <fe23cd68-461d-845a-13e9-93dd9493c1f9@xs4all.nl>
Message-ID: <1495510557.4116.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-05-22 at 16:16 +0200, Hans Verkuil wrote:
> On 05/22/2017 04:14 PM, Matthias Brugger wrote:
> > 
> > 
> > On 22/05/17 11:09, Hans Verkuil wrote:
> >> On 05/12/2017 05:22 AM, Minghsiu Tsai wrote:
> >>
> >> Who should take care of the dtsi changes? I'm not sure who maintains the mdp dts.
> > 
> > I will take care of the dtsi patches.
> > 
> >>
> >> The driver change and the dtsi change need to be in sync, so it is probably easiest
> >> to merge this via one tree.
> >>
> >> Here is my Acked-by for these three patches:
> >>
> >> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> >>
> >> I can take all three, provided I have the Ack of the mdp dts maintainer. Or it can
> >> go through him with my Ack.
> >>
> > 
> > I think we should provide backwards compability instead, as proposed here:
> > http://lists.infradead.org/pipermail/linux-mediatek/2017-May/008811.html
> > 
> > If this change is ok for you, please let Minghsiu know so that he can 
> > provide a v4.
> 
> That's a lot better. In that case I can take the media patches and you the dts.
> 
> I'll wait for the v4.
> 

Hi Hans, Matthias,

I have uploaded v4, thanks.


> Regards,
> 
> 	Hans
> 
> > 
> > Regards,
> > Matthias
> > 
> >> Regards,
> >>
> >> 	Hans
> >>
> >>> Changes in v3:
> >>> - Upload patches again because forget to add v2 in title
> >>>
> >>> Changes in v2:
> >>> - Update commit message
> >>>
> >>> If the mdp_* nodes are under an mdp sub-node, their corresponding
> >>> platform device does not automatically get its iommu assigned properly.
> >>>
> >>> Fix this by moving the mdp component nodes up a level such that they are
> >>> siblings of mdp and all other SoC subsystems.  This also simplifies the
> >>> device tree.
> >>>
> >>> Although it fixes iommu assignment issue, it also break compatibility
> >>> with old device tree. So, the patch in driver is needed to iterate over
> >>> sibling mdp device nodes, not child ones, to keep driver work properly.
> >>>
> >>> Daniel Kurtz (2):
> >>>    arm64: dts: mt8173: Fix mdp device tree
> >>>    media: mtk-mdp: Fix mdp device tree
> >>>
> >>> Minghsiu Tsai (1):
> >>>    dt-bindings: mt8173: Fix mdp device tree
> >>>
> >>>   .../devicetree/bindings/media/mediatek-mdp.txt     |  12 +-
> >>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 126 ++++++++++-----------
> >>>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |   2 +-
> >>>   3 files changed, 64 insertions(+), 76 deletions(-)
> >>>
> >>
> 
