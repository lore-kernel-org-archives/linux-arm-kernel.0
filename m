From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 30 Jan 2017 19:31:20 -0800
Subject: [PATCH v3 22/24] media: imx: Add MIPI CSI-2 OV5640 sensor subdev
 driver
In-Reply-To: <20170130232955.GK27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-23-git-send-email-steve_longerbeam@mentor.com>
 <20170130232955.GK27312@n2100.armlinux.org.uk>
Message-ID: <12fbe4d6-3e62-53b1-feef-011e1ad7affe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/30/2017 03:29 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2017 at 06:11:40PM -0800, Steve Longerbeam wrote:
>> +config IMX_OV5640_MIPI
>> +       tristate "OmniVision OV5640 MIPI CSI-2 camera support"
>> +       depends on GPIOLIB && VIDEO_IMX_CAMERA
>> +       select IMX_MIPI_CSI2
>> +       default y
> Why is this defaulting to y?  New drivers should not default to enabled
> unless they are replacing some already pre-existing functionality.
> Ditto for the other camera driver.

The ov564x sensors are required for the SabreSD and SabreLite/Nitrogen
reference boards (if VIDEO_IMX_CAMERA is enabled that is). But they're not
required for other platforms, so you're right I shouldn't have defaulted 
these
to yes. Fixed.


Steve
