From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Feb 2018 12:49:17 +0100
Subject: [PATCH v2 4/8] drm/rockchip: dw_hdmi: Allow outputs that don't
 need output switching
In-Reply-To: <f1104948-5b95-968c-edc4-7a4d5212bae0@arm.com>
References: <20180216204158.29839-1-heiko@sntech.de>
 <20180216204158.29839-5-heiko@sntech.de>
 <f1104948-5b95-968c-edc4-7a4d5212bae0@arm.com>
Message-ID: <1630677.YWXALm60yB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Am Montag, 19. Februar 2018, 12:43:11 CET schrieb Robin Murphy:
> Hi Heiko,
> 
> On 16/02/18 20:41, Heiko Stuebner wrote:
> > So far we always encountered socs with 2 output crtcs needing the driver
> > to tell the hdmi block which output to connect to. But there also exist
> > socs with only one crtc like the rk3228, rk3328 and rk3368.
> > 
> > So adapt the register field to simply carry a negative value to signal
> > that now output-switching is necessary.
> 
> Nit: s/now/no/ ? (Hooray for grammatically-correct typos which invert 
> the entire meaning of the sentence!)

:-D

> What are the necessary dependencies for these patches? I tried applying 
> the series on 4.16-rc1 to test, but it failed at patch #6 with some 
> missing context (I tried checking drm-next for where rockchip_hdmi::hdmi 
> might have come from, but didn't see anything obvious)

You'll need the most recent drm-misc changes [0], especially the dw-hdmi
changes from Jernej Skrabec that touch similar areas and even included a
similar patch to export some general phy functions, which I could drop
from my series.


Heiko

[0] https://cgit.freedesktop.org/drm/drm-misc/log/
