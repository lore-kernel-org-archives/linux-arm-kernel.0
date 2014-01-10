From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jan 2014 14:51:54 +0000
Subject: [RFC PATCH v2] staging: imx-hdmi: use rx sense status for plug
 detection if hpd is unreliable
In-Reply-To: <1389363744-559-1-git-send-email-p.zabel@pengutronix.de>
References: <1389363744-559-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140110145154.GD15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 03:22:24PM +0100, Philipp Zabel wrote:
> Due to the voltage divider on the HPD line, the HDMI connector on
> imx6q-sabrelite doesn't reliably detect connected DVI monitors.
> This patch allows to use the RX_SENSE0 signal as a workaround when
> enabled by a boolean device tree property 'hpd-unreliable'.

Yay, much nicer, easier to read, and smaller, thanks.  I'll add it to the
series.

I don't think we've had David Airlie's eyes on the series yet (but then
I think he's rather Rob Clark looked at non-x86 DRM stuff).  Also I've
yet to hear back from Greg wrt the component stuff, so I suspect this
series won't be making this merge window.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
