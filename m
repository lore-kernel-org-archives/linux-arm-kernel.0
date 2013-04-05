From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 5 Apr 2013 17:29:50 +0800
Subject: [PATCH] ARM i.MX6: Fix ldb_di clock selection
In-Reply-To: <1365084209-27240-1-git-send-email-dirk.behme@de.bosch.com>
References: <1365084209-27240-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130405092948.GF2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please help apply this as a fix for 3.9.

On Thu, Apr 04, 2013 at 04:03:29PM +0200, Dirk Behme wrote:
> According to the recent i.MX6 Quad technical reference manual, mode 0x4 (100b)
> of the CCM_CS2DCR register (address 0x020C402C) bits [11-9] and [14-12] select
> the PLL3 clock, and not the PLL3 PFD1 540M clock. In our code, the PLL3 root
> clock is named 'pll3_usb_otg', select this instead of the 540M clock.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Cc: <stable@vger.kernel.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
