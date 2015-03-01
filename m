From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 1 Mar 2015 23:23:12 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: fix deassert hardreset clkdm
 usecounting
In-Reply-To: <1424966760-30917-1-git-send-email-t-kristo@ti.com>
References: <1424966760-30917-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1503012322080.9987@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015, Tero Kristo wrote:

> Deasserting hardreset increases the usecount for the hwmod parent clockdomain
> always, however usecount is only decreased at end in certain error cases.
> This causes software supervised clockdomains to remain always on, preventing
> idle. Fixed by always releasing the hwmods clockdomain parent when exiting
> the function.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Carlos Hernandez <ceh@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks, queued for v4.0-rc fixes.


- Paul
