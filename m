From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 09 Apr 2013 09:44:46 +0200
Subject: [PATCH 0/7] i.MX53 IPU + TVE patches
In-Reply-To: <20130408174016.GB30036@kroah.com>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
 <20130408174016.GB30036@kroah.com>
Message-ID: <1365493486.4023.13.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am Montag, den 08.04.2013, 10:40 -0700 schrieb Greg Kroah-Hartman:
> On Mon, Apr 08, 2013 at 06:04:31PM +0200, Philipp Zabel wrote:
> > Hi,
> > 
> > the following patches allow to use the integrated Television Encoder
> > (TVEv2) on the i.MX53 SoC as VGA output encoder for the IPU. This is
> > useful for the Freescale i.MX53-QSB and TQ MBa53 boards, which have
> > VGA and DVI-I connectors, respectively.
> > 
> > regards
> > Philipp
> > 
> > ---
> >  drivers/staging/imx-drm/Kconfig             |   7 +
> >  drivers/staging/imx-drm/Makefile            |   1 +
> >  drivers/staging/imx-drm/imx-drm-core.c      |  15 +-
> >  drivers/staging/imx-drm/imx-drm.h           |  14 +-
> >  drivers/staging/imx-drm/imx-tve.c           | 755 ++++++++++++++++++++++++++++
> >  drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |   3 +
> >  drivers/staging/imx-drm/ipu-v3/ipu-dc.c     |  55 +-
> >  drivers/staging/imx-drm/ipu-v3/ipu-di.c     | 100 +++-
> >  drivers/staging/imx-drm/ipuv3-crtc.c        |  11 +-
> >  9 files changed, 932 insertions(+), 29 deletions(-)
> 
> That's a lot of new features being added here, yet no work seems to be
> happening to move this out of the staging tree.  What is left to do
> here, and why isn't that being worked on first, before stuff like this?

the IPU code could still use a bit of testing, and I hope adding
features like VGA output on common development boards will increase the
amount of scrutiny this code will get.
I expect the structure of the IPU drivers to change when the common
display framework gets introduced at last, also requiring changes to the
device tree bindings, and I'm a bit reluctant to push for mainline
proper while the bindings are still not clear.

regards
Philipp
