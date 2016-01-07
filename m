From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 07 Jan 2016 17:50:24 +0100
Subject: [RFC PATCH v2 3/4] drm: rockchip: hdmi: add RK3229 HDMI support
In-Reply-To: <568E3AD0.1020904@rock-chips.com>
References: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
 <1452157373-18783-1-git-send-email-ykk@rock-chips.com>
 <1452161052.4776.7.camel@pengutronix.de> <568E3AD0.1020904@rock-chips.com>
Message-ID: <1452185424.4776.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Donnerstag, den 07.01.2016, 18:15 +0800 schrieb Yakir Yang:
> Hi Philipp,
> 
> Thanks for your fast respond :)
> 
> On 01/07/2016 06:04 PM, Philipp Zabel wrote:
> > Am Donnerstag, den 07.01.2016, 17:02 +0800 schrieb Yakir Yang:
> >> RK3229 integrate an DesignedWare HDMI2.0 controller and an INNO HDMI2.0 phy,
> >> the max output resolution is 4K.
> >>
> >> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > It sounds like the INNO HDMI2.0 phy is not necessarily specific to
> > RK3229 but might also appear in other SoCs? If so, I think this should
> > be implemented in a separate phy driver and be used by dw_hdmi-rockchip.
> 
> Do you mean I should create a new phy driver that place in "driver/phy" 
> directly ?

Possibly, yes. The exynos video phys are already there. I have kept the
mediatek dsi/hdmi phys together with the DRM driver, but I suppose I
could move them there, too.

> I have think about this idea, and it would make things much clean. But 
> INNO PHY
> driver need the target pixel clock in drm_display_mode, I didn't find a 
> good way
> to pass this variable to separate phy driver. Do you have some idea ?

We'd need to extend the PHY API for this. For the mediatek phys we have
side-stepped the issue by wiring up the PLL output to the common clock
framework.
I expect besides the pixel clock frequency, it might also be necessary
to inform the PHY about cycles per pixel for deep color modes.

regards
Philipp
