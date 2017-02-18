From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Feb 2017 09:23:35 +0000
Subject: [PATCH v4 29/36] media: imx: mipi-csi2: enable setting and
 getting of frame rates
In-Reply-To: <24d42948-a77d-445f-e3e9-ab595b0cfc3e@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-30-git-send-email-steve_longerbeam@mentor.com>
 <24d42948-a77d-445f-e3e9-ab595b0cfc3e@gmail.com>
Message-ID: <20170218092335.GI21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 05:12:44PM -0800, Steve Longerbeam wrote:
> Hi Russell,
> 
> I signed-off on this but after more review I'm not sure this is right.
> 
> The CSI-2 receiver really has no control over frame rate. It's output
> frame rate is the same as the rate that is delivered to it.
> 
> So this subdev should either not implement these ops, or it should
> refer them to the attached source subdev.

Where in the V4L2 documentation does it say that is permissible?

If you don't implement these, media-ctl fails to propagate _anything_
to the next sink pad if you specify a frame rate, because media-ctl
throws an error and exits immediately.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
