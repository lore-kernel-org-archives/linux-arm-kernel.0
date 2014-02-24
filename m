From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Feb 2014 15:52:21 +0000
Subject: [RFC PATCH v3 2/9] staging: imx-drm: Add temporary copies of
 v4l2-of parsing functions
In-Reply-To: <1392723370-4772-3-git-send-email-p.zabel@pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
 <1392723370-4772-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140224155221.GM21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:36:03PM +0100, Philipp Zabel wrote:
> From: Philipp Zabel <philipp.zabel@gmail.com>
> 
> The existing v4l2-of parser functions for the video interface bindings
> described in Documentation/device-tree/bindings/media/video-interfaces.txt
> are useful for DRM drivers, too. They will be moved to drivers/media
> so they can be used by drm drivers, too. Until then, duplicate the
> v4l2-of parser functions temporarily.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Ergh.  So, because we can't get agreement on where to put the common
helpers, we have to put up with adding duplicate helpers into the
staging directory, inflating not only the kernel source code size
but also the binary size as well.

Come on people, get agreement on how to deal with this.  Staging may
be a dumping ground for drivers which aren't ready to be merged as
proper drivers, but this is no reason to ignore proper process.

Do we, or do we not want to get imx-drm out of drivers/staging?  If
we do, the only way that's going to happen is if we stop throwing in
this kind of stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
