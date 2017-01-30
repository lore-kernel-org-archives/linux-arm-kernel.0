From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 23:29:55 +0000
Subject: [PATCH v3 22/24] media: imx: Add MIPI CSI-2 OV5640 sensor subdev
 driver
In-Reply-To: <1483755102-24785-23-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-23-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170130232955.GK27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:40PM -0800, Steve Longerbeam wrote:
> +config IMX_OV5640_MIPI
> +       tristate "OmniVision OV5640 MIPI CSI-2 camera support"
> +       depends on GPIOLIB && VIDEO_IMX_CAMERA
> +       select IMX_MIPI_CSI2
> +       default y

Why is this defaulting to y?  New drivers should not default to enabled
unless they are replacing some already pre-existing functionality.
Ditto for the other camera driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
