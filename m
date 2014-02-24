From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Feb 2014 15:49:19 +0000
Subject: [RFC PATCH v3 1/9] staging: imx-drm-core: don't request probe
 deferral in imx_drm_encoder_parse_of
In-Reply-To: <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
 <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140224154919.GL21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:36:02PM +0100, Philipp Zabel wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Since imx_drm_encoder_parse_of is called from the encoder bind callbacks,
> it is too late to request probe deferral. Rather the core should make sure
> that the crtcs are bound before the encoders, after all needed components
> are probed.

Why is it too late?  -EPROBE_DEFER from this point will cause the driver
initialisation to correctly unwind and return -EPROBE_DEFER to the
last-to-be-added component.

> This fixes probe failure when using the LDB on i.MX6.

More details please.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
