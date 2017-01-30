From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 22:29:59 +0000
Subject: [PATCH v3 19/24] media: imx: Add IC subdev drivers
In-Reply-To: <1483755102-24785-20-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-20-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170130222959.GD27898@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:37PM -0800, Steve Longerbeam wrote:
> This is a set of three media entity subdevice drivers for the i.MX
> Image Converter. The i.MX IC module contains three independent
> "tasks":
> 
> - Pre-processing Encode task: video frames are routed directly from
>   the CSI and can be scaled, color-space converted, and rotated.
>   Scaled output is limited to 1024x1024 resolution. Output frames
>   are routed to the camera interface entities (camif).
> 
> - Pre-processing Viewfinder task: this task can perform the same
>   conversions as the pre-process encode task, but in addition can
>   be used for hardware motion compensated deinterlacing. Frames can
>   come either directly from the CSI or from the SMFC entities (memory
>   buffers via IDMAC channels). Scaled output is limited to 1024x1024
>   resolution. Output frames can be routed to various sinks including
>   the post-processing task entities.
> 
> - Post-processing task: same conversions as pre-process encode. However
>   this entity sends frames to the i.MX IPU image converter which supports
>   image tiling, which allows scaled output up to 4096x4096 resolution.
>   Output frames can be routed to the camera interfaces.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Applying: media: imx: Add IC subdev drivers
.git/rebase-apply/patch:3054: new blank line at EOF.
+
warning: 1 line adds whitespace errors.


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
