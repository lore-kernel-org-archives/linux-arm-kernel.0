From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 07 Apr 2014 14:34:15 +0200
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <1396865135.3811.13.camel@paszta.hi.pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <20140407042334.GA28025@dragon>
 <1396865135.3811.13.camel@paszta.hi.pengutronix.de>
Message-ID: <1396874055.3811.19.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 07.04.2014, 12:05 +0200 schrieb Philipp Zabel:
> Hi Shawn,
> 
> Am Montag, den 07.04.2014, 12:23 +0800 schrieb Shawn Guo:
> > On Tue, Mar 11, 2014 at 11:46:11AM +0800, Shawn Guo wrote:
> > > I just came across a couple problems when testing the series on
> > > my imx6dl-sabresd board in dual display case - HDMI + LVDS.  I tested it
> > > using Russell's branch below, which I believe has all the pieces put
> > > together.
> > > 
> > >   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
> > > 
> > > - When I enable HDMI and LVDS support in both kernel build and device
> > >   tree, HDMI seems working fine but LVDS color is corrupted quite badly.
> > 
> > Philipp,
> > 
> > Did you get any chance to reproduce this dual display issue?  Now it
> > shows on mainline kernel.
> 
> I have not yet reproduced, but I've sent a patch today ("imx-drm:
> imx-drm-core: Fix imx_drm_encoder_get_mux_id") that might fix this.

Tested on imx6q-phytec-pbab01 with LVDS panel and DVI monitor.

> > And I see another HDMI regression with my testing on mainline kernel.  I
> > can have my HDMI work at 1920x1080 with v3.14 kernel, but it can only
> > probes 1024x768 with the mainline today.  The Xorg.0.log are attached
> > below.  The hardware and user space are same, so I guess this is another
> > issue introduced by the recently kernel driver changes?
> 
> Hmm, not sure. Have you updated to the i2c-ddc-bus phandle property as
> described in Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt?

regards
Philipp
