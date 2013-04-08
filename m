From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 8 Apr 2013 10:40:16 -0700
Subject: [PATCH 0/7] i.MX53 IPU + TVE patches
In-Reply-To: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130408174016.GB30036@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 06:04:31PM +0200, Philipp Zabel wrote:
> Hi,
> 
> the following patches allow to use the integrated Television Encoder
> (TVEv2) on the i.MX53 SoC as VGA output encoder for the IPU. This is
> useful for the Freescale i.MX53-QSB and TQ MBa53 boards, which have
> VGA and DVI-I connectors, respectively.
> 
> regards
> Philipp
> 
> ---
>  drivers/staging/imx-drm/Kconfig             |   7 +
>  drivers/staging/imx-drm/Makefile            |   1 +
>  drivers/staging/imx-drm/imx-drm-core.c      |  15 +-
>  drivers/staging/imx-drm/imx-drm.h           |  14 +-
>  drivers/staging/imx-drm/imx-tve.c           | 755 ++++++++++++++++++++++++++++
>  drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |   3 +
>  drivers/staging/imx-drm/ipu-v3/ipu-dc.c     |  55 +-
>  drivers/staging/imx-drm/ipu-v3/ipu-di.c     | 100 +++-
>  drivers/staging/imx-drm/ipuv3-crtc.c        |  11 +-
>  9 files changed, 932 insertions(+), 29 deletions(-)

That's a lot of new features being added here, yet no work seems to be
happening to move this out of the staging tree.  What is left to do
here, and why isn't that being worked on first, before stuff like this?

thanks,

greg k-h
