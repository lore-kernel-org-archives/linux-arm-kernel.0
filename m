From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 22 Jun 2016 15:35:06 +0300
Subject: [PATCH v3 11/15] mmc: sdhci-of-arasan: Add ability to export card
 clock
In-Reply-To: <1466445414-11974-12-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-12-git-send-email-dianders@chromium.org>
Message-ID: <576A85FA.2000309@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/16 20:56, Douglas Anderson wrote:
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
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
