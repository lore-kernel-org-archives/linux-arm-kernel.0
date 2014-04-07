From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Apr 2014 21:43:04 +0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <1396865135.3811.13.camel@paszta.hi.pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <20140407042334.GA28025@dragon>
 <1396865135.3811.13.camel@paszta.hi.pengutronix.de>
Message-ID: <20140407134302.GB2438@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 12:05:35PM +0200, Philipp Zabel wrote:
> > Did you get any chance to reproduce this dual display issue?  Now it
> > shows on mainline kernel.
> 
> I have not yet reproduced, but I've sent a patch today ("imx-drm:
> imx-drm-core: Fix imx_drm_encoder_get_mux_id") that might fix this.

Yes, it fixes my issue.

> 
> > And I see another HDMI regression with my testing on mainline kernel.  I
> > can have my HDMI work at 1920x1080 with v3.14 kernel, but it can only
> > probes 1024x768 with the mainline today.  The Xorg.0.log are attached
> > below.  The hardware and user space are same, so I guess this is another
> > issue introduced by the recently kernel driver changes?
> 
> Hmm, not sure. Have you updated to the i2c-ddc-bus phandle property as
> described in Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt?

That's indeed the cause of my problem.  Thanks, Philipp.

Shawn
