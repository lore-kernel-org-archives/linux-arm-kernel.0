From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Mar 2014 22:14:31 +0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <1394544878.4339.7.camel@weser.hi.pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <1394538128.3772.15.camel@paszta.hi.pengutronix.de>
 <20140311132727.GB26502@S2101-09.ap.freescale.net>
 <1394544878.4339.7.camel@weser.hi.pengutronix.de>
Message-ID: <20140311141429.GC26502@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 02:34:38PM +0100, Lucas Stach wrote:
> > Sorry, Philipp.  The setup in my report is incorrect.  The correct setup
> > to see this issue consists of:
> > 
> > 1) build a kernel without HDMI support, i.e. !CONFIG_DRM_IMX_HDMI
> > 
> > 2) enable HDMI device in DT, i.e. adding the lines below in board dts.
> > 
> > 	&hdmi {
> > 	       status = "okay";
> > 	};
> > 
> > Sorry for the confusion.
> > 
> This isn't a supported use-case, the componentized device stuff is there
> exactly to ensure that the DRM device is only brought up after all
> active components have an driver attached to them.

Ah, yes.  I was in the impression that LVDS should still work in this
setup, but that was the case before Philipp's series.  In Russell's
original imx-drm setup, LVDS still works even if I enable the HDMI
device in DT, as long as I do not reference it from 'connectors'.

	imx_drm: imx-drm {
		compatible = "fsl,imx-drm";
		crtcs = <&ipu1 0>, <&ipu1 1>;
		connectors = <&ldb>;
	};

Thanks for the clarification.

Shawn
