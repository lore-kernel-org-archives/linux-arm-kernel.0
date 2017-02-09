From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 9 Feb 2017 15:51:47 -0800
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <d6dba77e-902c-7a4c-cc70-fe3a5c9649bb@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <1486036237.2289.37.camel@pengutronix.de>
 <ca0a2eb3-21b6-d312-c8e0-61da48c4c700@gmail.com>
 <20170208234235.GA27312@n2100.armlinux.org.uk>
 <d6dba77e-902c-7a4c-cc70-fe3a5c9649bb@gmail.com>
Message-ID: <e9076980-ce84-f9ee-096d-865243b82a9e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/09/2017 03:49 PM, Steve Longerbeam wrote:
>
>
> On 02/08/2017 03:42 PM, Russell King - ARM Linux wrote:
>> On Wed, Feb 08, 2017 at 03:23:53PM -0800, Steve Longerbeam wrote:
>>>> Actually, this exact function already exists as 
>>>> dw_mipi_dsi_phy_write in
>>>> drivers/gpu/drm/rockchip/dw-mipi-dsi.c, and it looks like the D-PHY
>>>> register 0x44 might contain a field called HSFREQRANGE_SEL.
>>> Thanks for pointing out drivers/gpu/drm/rockchip/dw-mipi-dsi.c.
>>> It's clear from that driver that there probably needs to be a fuller
>>> treatment of the D-PHY programming here, but I don't know where
>>> to find the MIPI CSI-2 D-PHY documentation for the i.MX6. The code
>>> in imxcsi2_reset() was also pulled from FSL, and that's all I really 
>>> have
>>> to go on for the D-PHY programming. I assume the D-PHY is also a
>>> Synopsys core, like the host controller, but the i.MX6 manual doesn't
>>> cover it.
>> Why exactly?  What problems are you seeing that would necessitate a
>> more detailed programming of the D-PHY?  From my testing, I can wind
>> a 2-lane MIPI bus on iMX6D from 912Mbps per lane down to (eg) 308Mbps
>> per lane with your existing code without any issues.
>
> That's good to hear.
>
> Just from my experience with struggles to get the CSI2 receiver
> up and running with an active clock lane, and my suspicions that
> some of that could be due to my lack of understanding of the D-PHY
> programming.

But I should add that after a re-org of the sequence, it looks more stable
now. Tested on both the SabreSD and SabreLite with the OV5640.

Steve
