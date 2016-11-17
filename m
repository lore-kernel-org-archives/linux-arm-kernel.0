From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 17 Nov 2016 13:36:46 +0800
Subject: [PATCH v5] drm/mediatek: fixed the calc method of data rate per
 lane
In-Reply-To: <1479266454-31892-1-git-send-email-jitao.shi@mediatek.com>
References: <1479266454-31892-1-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1479361006.13083.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jitao:


On Wed, 2016-11-16 at 11:20 +0800, Jitao Shi wrote:
> Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e.
> Tlpx, Ths-prepare, Ths-zero, Ths-trail,Ths-exit) when enter and exit LP
> mode, those signals will cause h-time larger than normal and reduce FPS.
> So need to multiply a coefficient to offset the extra signal's effect.
>   coefficient = ((htotal*bpp/lane_number)+Tlpx+Ths_prep+Ths_zero+
> 		 Ths_trail+Ths_exit)/(htotal*bpp/lane_number)
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

It looks good to me.
But this patch conflict with [1] which is one patch of MT2701 series. I
want to apply MT2701 patches first, so please help to refine this patch
based on MT2701 patches.

[1] https://patchwork.kernel.org/patch/9422821/

Regards,
CK

> ---
> Change since v4:
>  - tune the calc comment more clear.
>  - define the phy timings as constants.
> 
> Chnage since v3:
>  - wrapp the commit msg.
>  - fix alignment of some lines. 
> 
> Change since v2:
>  - move phy timing back to dsi_phy_timconfig.
> 
> Change since v1:
>  - phy_timing2 and phy_timing3 refer clock cycle time.
>  - define values of LPX HS_PRPR HS_ZERO HS_TRAIL TA_GO TA_SURE TA_GET DA_HS_EXIT.
> ---
>  
