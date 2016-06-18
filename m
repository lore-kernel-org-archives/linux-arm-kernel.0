From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 18 Jun 2016 19:59:47 +0200
Subject: [PATCH v2 04/11] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
In-Reply-To: <1465859076-4868-5-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-5-git-send-email-dianders@chromium.org>
Message-ID: <2413456.oe4vm1F1Mq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 16:04:28 schrieb Douglas Anderson:
> In the the earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs") we can see the
> mechansim for specifying a syscon to properly set corecfg registers in
> sdhci-of-arasan.  Now let's use this mechanism to properly set
> corecfg_baseclkfreq on rk3399.
> 
> From [1] the corecfg_baseclkfreq is supposed to be set to:
>   Base Clock Frequency for SD Clock.
>   This is the frequency of the xin_clk.
> 
> This is a relatively easy thing to do.  Note that we assume that xin_clk
> is not dynamic and we can check the clock at probe time.  If any real
> devices have a dynamic xin_clk future patches could register for
> notifiers for the clock.
> 
> At the moment, setting corecfg_baseclkfreq is only supported for rk3399
> since we need a specific map for each implementation.  The code is
> written in a generic way that should make this easy to extend to other
> SoCs.  Note that a specific compatible string for rk3399 is already in
> use and so we add that to the table to match rk3399.
> 
> [1]:
> https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

this looks nice and versatile for other socs hopefully using that in the 
future.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
