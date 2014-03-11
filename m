From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Mar 2014 11:46:11 +0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140311034607.GA26502@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:20:51AM +0100, Philipp Zabel wrote:
> Hi,
> 
> this latest version of the imx-drm DT binding patches applies
> on top of staging-next and also depends on the OF graph binding
> patchset that moves the v4l2_of helpers to drivers/of.
> Currently, the two patchsets are also available at:
>     git://git.pengutronix.de/git/pza/linux.git topic/of-graph
>     git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt

Hi Philipp,

I just came across a couple problems when testing the series on
my imx6dl-sabresd board in dual display case - HDMI + LVDS.  I tested it
using Russell's branch below, which I believe has all the pieces put
together.

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging

- When I enable HDMI and LVDS support in both kernel build and device
  tree, HDMI seems working fine but LVDS color is corrupted quite badly.

- When I enable HDMI and LVDS support in kernel build but only LVDS in
  device tree (keep HDMI disabled in device tree by not changing
  'status' of HDMI node to 'okay'), LVDS does not even work.  In this
  case, it seems that the binding of display-subsystem does not succeed.

Please confirm if they are real problems or I'm missing something here.

Shawn
