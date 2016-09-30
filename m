From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Fri, 30 Sep 2016 11:11:59 +0800
Subject: [PATCH] drm/mediatek: fix a typo
In-Reply-To: <1f324471-bebb-c8bf-75c1-391355c50a99@gmail.com>
References: <1475119322-58657-1-git-send-email-bibby.hsieh@mediatek.com>
 <1475121682.18843.2.camel@mtksdaap41>
 <1f324471-bebb-c8bf-75c1-391355c50a99@gmail.com>
Message-ID: <1475205119.13345.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-29 at 10:46 +0200, Matthias Brugger wrote:
> 
> On 29/09/16 06:01, CK Hu wrote:
> > Acked-by: CK Hu <ck.hu@mediatek.com>
> >
> > On Thu, 2016-09-29 at 11:22 +0800, Bibby Hsieh wrote:
> >> Fix the typo: OD_RELAYMODE->OD_CFG
> >>
> 

Hi, Matthias
Thanks for your reply.

> Although it is quite clear what the patch does, could you write one 
> sentence to explain what it does. Maybe explain even which effect it 
> has, which error get fixed etc.

Ok, I will do that.

> As we are getting public available boards now, we should take more care 
> about fixes. If you have a fix for a commit introduced in an earlier 
> version of linux and it should be fixed for this version as well (e.g. 
> v4.6 does have the feature but it does not work correctly) then please 
> add these two lines before your Signed-off-by:
> Fixes: <commit-hash> ("<commit subject line>")
> Cc: stable at vger.kernel.org # v4.6+
> 
> Where v4.6+ stands for the oldest version where this should get fixed.
> 

Ok, but the patch hasn't been merged into v4.8 (just in drm-next [1] and
linux-next [2]), how can I mark that?

[1]
https://cgit.freedesktop.org/~airlied/linux/commit/?h=drm-next&id=7216436420414144646f5d8343d061355fd23483
[2]
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=7216436420414144646f5d8343d061355fd23483


> Thanks a lot,
> Matthias
> 
> >> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> >> ---
> >>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> >> index df33b3c..aa5f20f 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> >> @@ -123,7 +123,7 @@ static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
> >>  			  unsigned int bpc)
> >>  {
> >>  	writel(w << 16 | h, comp->regs + DISP_OD_SIZE);
> >> -	writel(OD_RELAYMODE, comp->regs + OD_RELAYMODE);
> >> +	writel(OD_RELAYMODE, comp->regs + OD_CFG);
> >>  	mtk_dither_set(comp, bpc, DISP_OD_CFG);
> >>  }
> >>
> >
> >

-- 
Bibby
