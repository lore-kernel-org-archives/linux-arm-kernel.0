From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 17:22:43 +0000
Subject: [PATCH 1/2] imx-drm: imx-ldb: Add drm_panel support
In-Reply-To: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
References: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140307172243.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 02:54:39PM +0100, Philipp Zabel wrote:
> This patch allows to optionally attach the lvds-channel to a panel
> supported by a drm_panel driver instead of supplying the modes via
> device tree.

Hmm, I think something may be missing in this patch... you're introducing
calls into the drm panel code, but there's nothign which ensures that
code gets built alongside imx-ldb.c.  With imx-ldb built as a module,
I get:

ERROR: "drm_panel_attach" [drivers/staging/imx-drm/imx-ldb.ko] undefined!
ERROR: "of_drm_find_panel" [drivers/staging/imx-drm/imx-ldb.ko] undefined!

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
