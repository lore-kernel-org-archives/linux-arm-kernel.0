From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 1 Dec 2015 13:54:38 +0100
Subject: [PATCH v2 06/10] drm/hisilicon: Add vblank feature
In-Reply-To: <CAGd==06DT723n168txuJxo1ViVB8R_XiuRt8SroCbFcs=BhfFg@mail.gmail.com>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-7-git-send-email-xinliang.liu@linaro.org>
 <20151130075432.GF17050@phenom.ffwll.local>
 <CAGd==05xhhdA7FWveei4U91rGKCHRNLyRG3-kin5B2V+ao+GrA@mail.gmail.com>
 <20151201071325.GE17050@phenom.ffwll.local>
 <CAGd==06DT723n168txuJxo1ViVB8R_XiuRt8SroCbFcs=BhfFg@mail.gmail.com>
Message-ID: <20151201125438.GT17050@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:34:43PM +0800, Xinliang Liu wrote:
> On 1 December 2015 at 15:13, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Tue, Dec 01, 2015 at 11:16:19AM +0800, Xinliang Liu wrote:
> >> On 30 November 2015 at 15:54, Daniel Vetter <daniel@ffwll.ch> wrote:
> >> > On Sat, Nov 28, 2015 at 06:39:01PM +0800, Xinliang Liu wrote:
> >> >> Add vblank handle for ADE.
> >> >>
> >> >> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> >> >> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> >> >> Signed-off-by: Andy Green <andy.green@linaro.org>
> >> >> ---
> >> >>  drivers/gpu/drm/hisilicon/hisi_drm_ade.c | 78 ++++++++++++++++++++++++++++++++
> >> >>  drivers/gpu/drm/hisilicon/hisi_drm_ade.h | 16 +++++++
> >> >>  drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 19 +++++++-
> >> >>  3 files changed, 112 insertions(+), 1 deletion(-)
> >> >>  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_ade.h
> >> >>
> >> >> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> >> >> index b0976c3..acb11e7 100644
> >> >> --- a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> >> >> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> >> >> @@ -267,7 +267,79 @@ static void ade_power_down(struct ade_hw_ctx *ctx)
> >> >>       ctx->power_on = false;
> >> >>  }
> >> >>
> >> >> +static struct drm_crtc *hisi_get_crtc_from_index(struct drm_device *dev,
> >> >> +                                              unsigned int index)
> >> >
> >> > Ugly that you had to add this, but unfortunately necessary :( Fixing up
> >> > the drm vblank hooks so that they deal with struct drm_crtc directly is
> >> > somewhere on my todo. But drm_irq.c is still a bit a mess, so this is some
> >> > ways off still.
> >> >
> >> > What might be possible as a follow-up cleanup though is to add
> >> > vblank_enable and vblank_disable functions to struct
> >> > drm_crtc_helper_funcs. And then provide this code here to map from int
> >> > index to struct drm_crtc * as helpers in a new drm_vblank_helper.c file.
> >> > That might be a good intermediate step.
> >>
> >> I would like to have a try to make this intermediate step patch and
> >> send out for review soon.
> >
> > Awesome, looking forward to reviewing it. If you have questions about
> > details fastest to ping me on irc (nick: danvet, #dri-devel on
> > freenode.net).
> 
> Great!  What't your time zone. So that I can ping you in right time.

Europe, GMT+1.

Cheers, Daniel

> 
> Thanks,
> -xinliang
> 
> >
> > Cheers, Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
