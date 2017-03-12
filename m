From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sat, 11 Mar 2017 16:30:53 -0800
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170310201356.GA21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170310201356.GA21222@n2100.armlinux.org.uk>
Message-ID: <47542ef8-3e91-b4cd-cc65-95000105f172@gmail.com>
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

If it's too difficult to get the imx219 csi-2 transmitter into the
LP-11 state on power on, perhaps the csi-2 receiver can be a little
more lenient on the transmitter and make the LP-11 timeout a warning
instead of error-out.

Can you try the attached change on top of the version 5 patchset?

If that doesn't work then you're just going to have to fix the bug
in imx219.

Steve
-------------- next part --------------
A non-text attachment was scrubbed...
Name: warn-on-lp-11-timeout.diff
Type: text/x-patch
Size: 611 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/3b438f44/attachment.bin>
