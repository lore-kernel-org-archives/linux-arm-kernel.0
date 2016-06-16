From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Jun 2016 01:54:54 +0200
Subject: [PATCH v2.1 07/11] mmc: sdhci-of-arasan: Add ability to export
 card clock
In-Reply-To: <1466008675-9357-8-git-send-email-dianders@chromium.org>
References: <1466008675-9357-8-git-send-email-dianders@chromium.org>
Message-ID: <2078624.p3pqVZlzC3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. Juni 2016, 09:37:51 schrieb Douglas Anderson:
> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> with arasan,sdhci-5.1) need to know the card clock in order to function
> properly.  Let's add the ability to expose this clock.  Any PHY that
> needs to know the clock rate can add a reference and query the clock
> rate.
> 
> At the moment we register a CLK_GET_RATE_NOCACHE clock that simply
> allows querying the clock.  This allows us to be less intrusive with
> regards to the main SDHCI driver, which has complex logic for adjusting
> the SD clock.  Right now we always fully power cycle the PHY when the
> clock changes and that gives the PHY a good chance to query our clock.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

for me this looks very nice implementation-wise and I also didn't spot 
glaring things, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

and as states in the original series, on a rk3399-evb
Tested-by: Heiko Stuebner <heiko@sntech.de>
