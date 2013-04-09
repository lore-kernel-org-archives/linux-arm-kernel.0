From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 19:50:20 +0800
Subject: [PATCH] ARM i.MX6: Fix ldb_di clock selection
In-Reply-To: <20130405092948.GF2667@S2101-09.ap.freescale.net>
References: <1365084209-27240-1-git-send-email-dirk.behme@de.bosch.com>
 <20130405092948.GF2667@S2101-09.ap.freescale.net>
Message-ID: <20130409115018.GH5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 05:29:50PM +0800, Shawn Guo wrote:
> Arnd, Olof,
> 
> Please help apply this as a fix for 3.9.
> 
I will send a new pull request which includes this fix.

Shawn

> On Thu, Apr 04, 2013 at 04:03:29PM +0200, Dirk Behme wrote:
> > According to the recent i.MX6 Quad technical reference manual, mode 0x4 (100b)
> > of the CCM_CS2DCR register (address 0x020C402C) bits [11-9] and [14-12] select
> > the PLL3 clock, and not the PLL3 PFD1 540M clock. In our code, the PLL3 root
> > clock is named 'pll3_usb_otg', select this instead of the 540M clock.
> > 
> > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> 
> Cc: <stable@vger.kernel.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
