From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 13 Jun 2018 18:04:24 +0200
Subject: [linux-sunxi] Re: [PATCH v2 24/27] drm: of: Export
 drm_crtc_port_mask()
In-Reply-To: <20180613073605.gnhcwrywooxhyryj@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-25-jernej.skrabec@siol.net>
 <20180613073605.gnhcwrywooxhyryj@flea>
Message-ID: <1909375.AJdhpVkKnf@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne sreda, 13. junij 2018 ob 09:36:05 CEST je Maxime Ripard napisal(a):
> On Tue, Jun 12, 2018 at 10:00:33PM +0200, Jernej Skrabec wrote:
> > Function is useful when drm_of_find_possible_crtcs() can't be used and
> > custom parsing is needed. This can happen for example when there is a
> > node with multiple muxes between crtc and encoder.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/drm_of.c | 4 ++--
> >  include/drm/drm_of.h     | 8 ++++++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index 1fe122461298..2e9cea3287b2 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -22,8 +22,8 @@ static void drm_release_of(struct device *dev, void
> > *data)> 
> >   * Given a port OF node, return the possible mask of the corresponding
> >   * CRTC within a device's list of CRTCs.  Returns zero if not found.
> >   */
> > 
> > -static uint32_t drm_crtc_port_mask(struct drm_device *dev,
> > -				   struct device_node *port)
> > +uint32_t drm_crtc_port_mask(struct drm_device *dev,
> > +			    struct device_node *port)
> 
> It should probably be exported too?

Yes, of course. It will be in next version.

Best regards,
Jernej
