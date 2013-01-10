From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 07:17:19 -0500
Subject: Fix phy_init for Marvell network eth driver
In-Reply-To: <1357819234-27752-1-git-send-email-konszert@marvell.com>
References: <1357819234-27752-1-git-send-email-konszert@marvell.com>
Message-ID: <20130110121719.GL5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 02:00:32PM +0200, Kosta Zertsekel wrote:
> Hi all,
> resubmitting the patch for Marvell mv643xx driver (patch 1/2) adding the below explanation (thanks to Florian F.):
> The D-Link DNS323_REV_C1 board has a specific PHY device fixup using the flag MARVELL_PHY_M1118_DNS323_LEDS which is set by the architecture code in arch/arm/mach-orion5x/dns323-setup.c. This flag is unfortunately lost during the call to phy_attach() in mv643xx_eth and therefore, the underlying Marvell PHY driver cannot make use of this flag to fixup the PHY device LEDs. This patch ensures the phy->dev_flags value is passed to the phy_attach() function such that the PHY device driver can
> actually use it.
> 
> Also submitting new patch 2/2 using the same (or at least very close in meaning) explanation.

Could you please put the above description in the patch commit log for
both patches?  Other than that,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
