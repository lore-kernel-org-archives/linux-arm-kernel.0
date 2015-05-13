From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 13 May 2015 17:01:50 +0100
Subject: [RFC][PATCH 2/2] drm/mediatek: Add DRM Driver for Mediatek SoC
 MT8173.
In-Reply-To: <1431530626-31493-3-git-send-email-ck.hu@mediatek.com>
References: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
 <1431530626-31493-3-git-send-email-ck.hu@mediatek.com>
Message-ID: <CAPj87rMCHK7FFgeHVwFNTwx7s6WHKx9-s70MbDsuc6WfwxVoSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13 May 2015 at 16:23, CK Hu <ck.hu@mediatek.com> wrote:
> +       /*
> +        * copy the mode data adjusted by mode_fixup() into crtc->mode
> +        * so that hardware can be seet to proper mode.
> +        */
> +       memcpy(&crtc->mode, adjusted_mode, sizeof(*adjusted_mode));

Please do not do this. adjusted_mode is already available in crtc->hwmode.

Please also restructure this driver to use the atomic infrastructure.
A good example of how to do this can be found in the Rockchip RK3288
driver which was submitted a while ago: it started off as a legacy
driver like this, but was converted during the submission phase.

I'm sure there are many more comments to come, but certainly
converting to be an atomic driver is the very first step.

Cheers,
Daniel
