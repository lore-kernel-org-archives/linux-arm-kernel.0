From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 12 Sep 2016 18:15:47 +0800
Subject: [PATCH v7 8/9] drm/mediatek: update DSI sub driver flow
In-Reply-To: <1473224283.11736.27.camel@mtksdaap41>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-9-git-send-email-yt.shen@mediatek.com>
 <1473224283.11736.27.camel@mtksdaap41>
Message-ID: <1473675347.12398.24.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Wed, 2016-09-07 at 12:58 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> > This patch update enable/disable flow of DSI module and MIPI TX module
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> 
> I think the description is too simple. Please briefly describe WHY of
> this patch. The original enable/disable flow is workable, so why do you
> need this patch? Without this patch, what problem would happen?
Got it, we will update more descriptions in the next version.
There is no transfer/interrupt function in the upstream DSI driver.
We also implement the following function [1][2] in this patch series.

Original flow works on there is a bridge chip: DSI -> bridge -> panel.
In this case: DSI -> panel, the DSI sub driver flow should be updated.
We need to initialize DSI first so that we can send commands to panel.

[1] https://patchwork.kernel.org/patch/9310819/
drm/mediatek: add dsi interrupt control
[2] https://patchwork.kernel.org/patch/9310823/
drm/mediatek: add dsi transfer function

> 
> Regards,
> CK
> 
> 
