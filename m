From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Apr 2016 01:03:17 +0200
Subject: bug in autoloading of imx-ipuv3-crtc
In-Reply-To: <1513165.9WxCa41tI1@anubis.ausil.us>
References: <6926808.b0joqYQPQE@anubis.ausil.us>
 <20160419185049.GC19428@n2100.arm.linux.org.uk>
 <2530051.TK07cZHuGk@anubis.ausil.us>
 <1513165.9WxCa41tI1@anubis.ausil.us>
Message-ID: <20160420230317.GT29108@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 19, 2016 at 03:16:01PM -0500, Dennis Gilmore wrote:
> On Tuesday, April 19, 2016 2:27:17 PM CDT Dennis Gilmore wrote:
> > On Tuesday, April 19, 2016 7:50:49 PM CDT Russell King - ARM Linux wrote:
> > > On Tue, Apr 19, 2016 at 01:34:23PM -0500, Dennis Gilmore wrote:
> > > > on all of my i.MX6 systems imx-ipuv3-crtc ius not getting automatically
> > > > loaded.  Everything is built as a module
> > > > 
> > > > CONFIG_DRM_IMX=m
> > > > CONFIG_DRM_IMX_FB_HELPER=m
> > > > CONFIG_DRM_IMX_HDMI=m
> > > > CONFIG_DRM_IMX_IPUV3=m
> > > > CONFIG_DRM_IMX_LDB=m
> > > > CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > > > CONFIG_DRM_IMX_TVE=m
> > > > CONFIG_IMX_IPUV3_CORE=m
> > > > 
> > > > The result is that until I log in via serial or ssh and modprobe the
> > > > module there is no display.  I suspect that there is some devicetree
> > > > glue missing 4.4 and 4.5 seem to both be effected.
> > > 
> > > DT doesn't come into it for imx-ipuv3-crtc - these platform devices are
> > > created by drivers/gpu/ipu-v3/ipu-common.c itself.
> > > 
> > > drivers/gpu/drm/imx/ipuv3-crtc.c contains the proper module alias which
> > > should result in the module loaded at boot time when the imx-ipuv3-crtc
> > > devices are created.
> > > 
> > > Could the problem be that imx-ipu-v3 isn't being loaded?  However, again,
> > > it looks to me like everything is correct there.
> > > 
> > > Are you saying that this used to work in older kernel versions like 4.3,
> > > but stopped in 4.4?
> > 
> > yers it used to work and stopped working. I would need to go back and test
> > old kernels to figure out where it broke.
> 
> after installing some old kernels it broke with 4.4-rc4 which included a patch 
> with teh subject of "drm/imx: Remove of_node assignment from ipuv3-crtc driver 
> probe"

Just to be sure: 4.4-rc4 with 407c9eba7897 ("drm/imx: Remove of_node
assignment from ipuv3-crtc driver probe") reverted works fine for you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
