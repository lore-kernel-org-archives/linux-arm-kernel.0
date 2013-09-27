From: B18965@freescale.com (Wang Huan-B18965)
Date: Fri, 27 Sep 2013 05:29:04 +0000
Subject: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver for
 Vybrid VF610 platform
In-Reply-To: <523C1DAB.60808@ti.com>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D83F448E@039-SN1MPN1-002.039d.mgd.msft.net>
 <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
 <52270C71.7080805@ti.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D842FD6A@039-SN1MPN1-003.039d.mgd.msft.net>
 <523C1DAB.60808@ti.com>
Message-ID: <81BA6E5E0BC2344391CABCEE22D1B6D84426AA@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> On 03/09/13 11:21, Wang Huan-B18965 wrote:
> >>> Hi, Jean-Christophe, Tomi,
> >>>
> >>> Could you please help to review these patches? Thanks!
> >>
> >> There seemed to be some strong opinions that there should be a drm
> >> driver for this hardware, instead of an fb driver. So as there seems
> >> to be disagreements about this, I'll leave this series to
> >> Jean-Christophe, who's the primary maintainer.
> > [Alison Wang]
> >
> > Thanks for Tomi's comments.
> >
> > I agree that we can implement the DRM driver for the DCU. As the
> > bandwidth limitation, I suggest we use the fb driver firstly. On the
> > other hand, the fb driver can meet the application requirement based
> > on this SoC. We'll try to provide the DRM driver when this IP
> > integrated into other SoC.
> 
> If you plan to move to DRM driver anyway, I would strongly suggest
> merging only the DRM driver. If we merge the fb driver, and a bit later
> the DRM driver for the same hardware, we'll have two drivers of which
> the other is already deprecated.
> 
[Alison Wang] We will not have bandwidth and develop the DRM driver in the near future. On the other hand, this IP is not integrated into other high-end SOC. So this fb driver will be used for some kind of long time for current SoC. We can try to remove the fb driver when we developed the DRM driver for other SoC.

Jean-Christophe, Do you have any comments? Thanks.


Best Regards,
Alison Wang
