From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Mar 2018 15:47:14 +0530
Subject: [PATCH] ARM: davinci: DA8XX: fix oops in USB PHY driver due to
 stack allocated platform platform_data
In-Reply-To: <1521136976-32730-1-git-send-email-david@lechnology.com>
References: <1521136976-32730-1-git-send-email-david@lechnology.com>
Message-ID: <382a269a-f486-8c1a-23b2-9620a01a073c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2018 11:32 PM, David Lechner wrote:
> This fixes a possible kernel oops due to using stack allocated platform
> data for the USB PHY driver on DA8XX devices. If the platform device
> probe is deferred, then we get a corrupt pointer for the platform data.
> 
> We now use a global static struct for the platform data so that the
> platform data pointer does not get written over.
> 
> Tested on OMAP-L138 LCDK board using legacy board file.

Oops. That should have been caught in review.

> 
> Fixes: 9b504750923cb ("ARM: davinci: da8xx: Add USB PHY platform device")

The offending commit seems to be bdec5a6b5789 ("ARM: da8xx: use platform
data for CFGCHIP syscon regmap") in my tree which should be in
linux-next. I don't think we have this issue in mainline. Right?

> Signed-off-by: David Lechner <david@lechnology.com>

Thanks,
Sekhar
