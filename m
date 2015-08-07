From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 7 Aug 2015 13:25:35 +0200
Subject: [RFC PATCH 2/8] drm: exynos/dp: convert to drm bridge mode
In-Reply-To: <55C36F49.6020207@rock-chips.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
 <1438870041-23130-1-git-send-email-ykk@rock-chips.com>
 <000001d0d052$f44fa3a0$dceeeae0$@com>
 <55C36F49.6020207@rock-chips.com>
Message-ID: <20150807112535.GK17734@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:29:29PM +0800, Yakir Yang wrote:
> Hi Jingoo,
> 
> ? 2015/8/6 22:19, Jingoo Han ??:
> >On Thursday, August 06, 2015 11:07 PM, Yakir Yang wrote:
> >>In order to move exynos dp code to bridge directory,
> >>we need to convert driver drm bridge mode first. As
> >>dp driver already have a ptn3460 bridge, so we need
> >>to move ptn bridge to the next bridge of dp bridge.
> >>
> >>Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >>---
> >>  drivers/gpu/drm/exynos/exynos_dp_core.c | 196 ++++++++++++++++++++------------
> >>  drivers/gpu/drm/exynos/exynos_dp_core.h |   2 +
> >>  2 files changed, 126 insertions(+), 72 deletions(-)
> >>
> >>diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
> >>index a8097a4..aa99e23 100644
> >>--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> >>+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
> >>@@ -3,6 +3,7 @@
> >>   *
> >>   * Copyright (C) 2012 Samsung Electronics Co., Ltd.
> >>   * Author: Jingoo Han <jg1.han@samsung.com>
> >>+ *         Yakir Yang <ykk@rock-chips.com>
> >Please don't add this.
> >You just fixed some parts of this code. I don't find the reason
> >why you have to be added to author for this file.
> >If you want the title for an author, please send the patch
> >for a new IP, instead of modifying the exiting codes.
> 
> Okay, thanks for your remind ;)

tbh the author lines are completely irrelevant, git blame/log is the
authoritative source for that. Copyright is a bit a different matter
entirely, but in general we seem to be not too good at updating.

Really if that's all you have to comment and no substantial technical
concerns or questions then just can such a bikeshed mail.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
