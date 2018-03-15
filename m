From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 14:14:59 -0500
Subject: [PATCH] ARM: davinci: DA8XX: fix oops in USB PHY driver due to
 stack allocated platform platform_data
In-Reply-To: <1521136976-32730-1-git-send-email-david@lechnology.com>
References: <1521136976-32730-1-git-send-email-david@lechnology.com>
Message-ID: <77b0430f-3606-7195-6cde-eb90fc00c3fd@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2018 01:02 PM, David Lechner wrote:
> This fixes a possible kernel oops due to using stack allocated platform
> data for the USB PHY driver on DA8XX devices. If the platform device
> probe is deferred, then we get a corrupt pointer for the platform data.
> 
> We now use a global static struct for the platform data so that the
> platform data pointer does not get written over.
> 
> Tested on OMAP-L138 LCDK board using legacy board file.
> 
> Fixes: 9b504750923cb ("ARM: davinci: da8xx: Add USB PHY platform device")
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

superseded by v2 that applies cleanly before common clock series
