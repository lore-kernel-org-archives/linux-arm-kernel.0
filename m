From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 20 Nov 2018 18:23:23 +0800
Subject: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
In-Reply-To: <9a445746-b07d-73e1-68c9-10eb9d5bf771@gmail.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41>
 <9a445746-b07d-73e1-68c9-10eb9d5bf771@gmail.com>
Message-ID: <1542709403.13494.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias:

On Tue, 2018-11-20 at 11:19 +0100, Matthias Brugger wrote:
> 
> On 20/11/2018 05:05, CK Hu wrote:
> > Hi, Matthias:
> > 
> > On Mon, 2018-11-19 at 10:26 +0100, Matthias Brugger wrote:
> >>
> >> On 19/11/2018 06:38, CK Hu wrote:
> >>> Hi, Matthias:
> >>>
> >>> On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg at kernel.org wrote:
> >>>> From: Matthias Brugger <mbrugger@suse.com>
> >>>>
> >>>> It can happen that the mmsys clock drivers aren't probed before the
> >>>> platform driver gets invoked. The platform driver used to print a warning
> >>>> that the driver failed to get the clocks. Omit this error on
> >>>> the defered probe path.
> >>>
> >>> This patch looks good to me, but you have not modified the sub driver in
> >>> HDMI path. We could let HDMI path print the warning and someone send
> >>> another patch later, or you modify for HDMI path in this patch.
> >>
> >> Sure, I'll add this in v6. After inspecting the code, I think we will need to
> >> also check for not initialized clocks in mtk_mdp_comp_init, as the driver for
> >> now does not even check if the clocks are present. What do you think?
> > 
> > Yes, we do really need to consider mdp driver because mmsys clock
> > include mdp clock. You remind me that mmsys control 4 major function:
> > drm routing, drm clock, mdp routing, and mdp clock. Your design let the
> > mmsys device as drm device (control drm routing) and create a sub device
> > as clock device (control drm clock, mdp clock). If one day mdp device
> > (may need control drm routing) need to control the register of mdp
> > routing, would mdp device be a sub device? Or we need not to consider
> > this because it need not to access mmsys register now?
> > 
> 
> I think we should for now concentrate to fix the clock probing issue. If in the
> future we will need to access drm routing from the mdp device, we can have a
> look into this.
> 
> Sounds good?

Sounds good to me.

Regards,
CK

> Regards,
> Matthias
