From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Oct 2015 00:07:30 -0300
Subject: i.mx6 video out in mainline
In-Reply-To: <CAD1M061RTNOCuE5vwrTsR3mgOaWcuwt5mc-L+K3kdLCDQ=JfLQ@mail.gmail.com>
References: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
 <CAOMZO5CwjC2dq3fWugAJsqThxAZ6o4wv0gV7ues28a51z0fXLg@mail.gmail.com>
 <CAD1M061RTNOCuE5vwrTsR3mgOaWcuwt5mc-L+K3kdLCDQ=JfLQ@mail.gmail.com>
Message-ID: <CAOMZO5CXRaR-dd4XT28qiZkCxd9iUdZr0RzwHixjeQ2L4RG2kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 8:02 PM, Pushpal Sidhu <psidhu@gateworks.com> wrote:

> When I took your patch and adapted it for imx6qdl-gw54xx.dtsi, I found
> that HDMI video out was slightly shifted to the left and resolution
> remained at 1024x768p.
>
> I also found that when I disabled DRM_IMX_LDB, HDMI out stopped
> working altogether, though if I stripped out the ldb section in device
> tree, the resolution comes back at 1080p (regardless of setting
> DRM_IMX_LDB or not). There is definitely some strange interdependency
> between lvds and hdmi here. Do you have an idea of where I should
> start looking for this problem?

I thought we have already fixed that. Does this issue still happen with 4.3-rc4?

I would suggest turning on debug in drivers/gpu/ipu-v3/ipu-di.c and
see the DI frequencies you are getting for the HDMI and LDB ports.
