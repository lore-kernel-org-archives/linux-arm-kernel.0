From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 11 Apr 2017 22:51:32 +0200
Subject: [PATCH v5 04/10] drm/stm: Add STM32 LTDC driver
In-Reply-To: <87wpaqeks2.fsf@eliezer.anholt.net>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
 <1490694293-18358-5-git-send-email-yannick.fertre@st.com>
 <87wpaqeks2.fsf@eliezer.anholt.net>
Message-ID: <20170411205132.sze2wfnnim4halqb@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 01:45:01PM -0700, Eric Anholt wrote:
> Yannick Fertre <yannick.fertre@st.com> writes:
> > +static void ltdc_crtc_disable(struct drm_crtc *crtc)
> > +{
> > +	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
> > +	struct drm_pending_vblank_event *event = crtc->state->event;
> > +
> > +	DRM_DEBUG_DRIVER("\n");
> > +
> > +	if (!crtc->enabled) {
> > +		DRM_DEBUG_DRIVER("already disabled\n");
> > +		return;
> > +	}
> 
> I think this crtc->enabled is a given for the disable() being called.

Yup, one design principle of atomic (compared to the legacy modeset
helpers) is to correctly keep track of hw state and not call a hook when
not needed. If you don't trust them, conver them to WARN_ON, but otherwise
best to remove.

But like Eric said, totally fine in a follow-up patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
