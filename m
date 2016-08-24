From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 25 Aug 2016 00:25:03 +0200
Subject: [PATCH] clk: rockchip: mark aclk_emmc_noc as a critical clock on
 rk3399
In-Reply-To: <1472063379-717-1-git-send-email-dianders@chromium.org>
References: <1472063379-717-1-git-send-email-dianders@chromium.org>
Message-ID: <1770264.XeNEc6mIDD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. August 2016, 11:29:39 schrieb Douglas Anderson:
> From: Xing Zheng <zhengxing@rock-chips.com>
> 
> We don't have code to handle any of the noc clocks in rk3399 and they're
> all just listed as critical clocks.  Let's do the same for
> aclk_emmc_noc.
> 
> Without this clock being marked as critical we have problems around
> suspend/resume after commit 20c389e656a8 ("clk: rockchip: fix incorrect
> aclk_emmc source gate bits on rk3399").  Before that change we were
> presumably not actually gating any of these clocks because we were
> setting the wrong gate.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my clk-fixes branch

Thanks
Heiko
