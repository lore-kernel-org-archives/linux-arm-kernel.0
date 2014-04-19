From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 19 Apr 2014 13:53:08 +0800
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140418204249.GG24070@n2100.arm.linux.org.uk>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <20140418204249.GG24070@n2100.arm.linux.org.uk>
Message-ID: <20140419055205.GX2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:42:49PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 14, 2014 at 10:02:26AM +0800, Shawn Guo wrote:
> > In a board setup which disables LDB device node completely by changing
> > status to 'disabled', and only enables HDMI device, we're running into
> > the problem that imx-drm master never succeeds in binding, and hence
> > HDMI does not come up either.
> > 
> > &ldb {
> > 	status = "disabled";
> > 
> > 	lvds-channel at 1 {
> > 		...
> > 		status = "okay";
> > 	};
> > };
> > 
> > The imx-drm-core should really skip the LVDS channels no matter what
> > lvds-channel's status is, if LDB device is disabled.  Let's consider
> > such setup a misconfiguration, give a warning in there and not add the
> > component.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes since v1:
> > * Put a warning on such misconfiguration
> 
> Thanks Shawn, I've added it to my queue for Greg.

Thanks, Russell.

BTW, can you take a look at the following two patches, or are they
already in your queue?

imx-drm: imx-drm-core: Fix imx_drm_encoder_get_mux_id
https://lkml.org/lkml/2014/4/7/58

mx-drm: imx-tve: correct DDC property name to 'ddc-i2c-bus'
('i' is missing from the prefix word, and it should be 'imx-drm')
http://www.spinics.net/lists/arm-kernel/msg321057.html

Shawn
