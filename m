From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Jun 2016 01:36:45 +0200
Subject: [PATCH 3/4] phy: rockchip-emmc: configure default output tap delay
In-Reply-To: <1463092986-61777-3-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-3-git-send-email-briannorris@chromium.org>
Message-ID: <1614232.pce5aJ6WZ3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Mai 2016, 15:43:05 schrieb Brian Norris:
> The output tap delay controls helps maintain the hold requirements for
> eMMC. The exact value is dependent on the SoC and other factors, though
> it isn't really an exact science. But the default of 0 is not very good,
> as it doesn't give the eMMC much hold time, so let's bump up to 4
> (approx 90 degree phase?). If we need to configure this any further
> (e.g., based on board or speed factors), we may need to consider a
> device tree representation.
> 
> Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

on my rk3399-evb board the emmc still runs nicely with this patch, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
