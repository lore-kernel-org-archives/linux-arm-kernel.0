From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Jan 2016 16:38:16 +0100
Subject: [linux-sunxi] [PATCH v2 16/26] drm: Add Allwinner A10 Display
 Engine support
In-Reply-To: <1452957104.12419.12.camel@plaes.org>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-17-git-send-email-maxime.ripard@free-electrons.com>
 <1452957104.12419.12.camel@plaes.org>
Message-ID: <20160119153816.GV4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 16, 2016 at 05:11:44PM +0200, Priit Laes wrote:
> > +struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
> > +{
> > +	drm_mode_config_reset(drm);
> > +
> > +	drm->mode_config.max_width = 8192;
> > +	drm->mode_config.max_height = 8192;
> 
> Shouldn't these be 1920 x 1080 as per A10 User manual?

1080p is what the SoC can output. However, to create its output, it
uses a combination of planes of 8192x8192, that you'll obviously have
to crop. This is the size of the plane that we are exposing here, not
what we can output (which is listed in the various connectors).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160119/e2a63c5c/attachment.sig>
