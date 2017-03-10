From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 10 Mar 2017 15:20:34 -0800
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170310201356.GA21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170310201356.GA21222@n2100.armlinux.org.uk>
Message-ID: <26d4a31f-f9d3-8b2b-391e-fc4b44cc8e5d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/2017 12:13 PM, Russell King - ARM Linux wrote:
> Version 5 gives me no v4l2 controls exposed through the video device
> interface.
>
> Just like with version 4, version 5 is completely useless with IMX219:
>
> imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000200
> ipu1_csi0: pipeline start failed with -110
> imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000200
> ipu1_csi0: pipeline start failed with -110
> imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000200
> ipu1_csi0: pipeline start failed with -110
>
> So, like v4, I can't do any further testing.
>

Is the imx219 placing the csi-2 bus in LP-11 state on exit
from s_power(ON)?

I realize that probably means bringing the chip up to a
completely operational state and then setting it to stream
OFF in the s_power() op.

The same had to be done for the OV5640.

Steve
