From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:08:07 -0800
Subject: [PATCH] ARM: rockchip: disable jtag/sdmmc autoswitching on rk3288
In-Reply-To: <27329915.EKTrifTJzR@phil>
References: <27329915.EKTrifTJzR@phil>
Message-ID: <20150112220807.GB22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 11:09:23PM +0100, Heiko St?bner wrote:
> rk3288 SoCs have a function to automatically switch between jtag/sdmmc pinmux
> settings depending on the card state. This collides with a lot of assumptions.
> 
> It only works when using the internal card-detect mechanism and breaks
> horribly when using either the normal card-detect via the slot-gpio function
> or via any other pin. Also there is of course no link between the mmc and jtag
> on the software-side, so the jtag clocks may very well be disabled when the
> card is ejected and the soc switches back to the jtag pinmux.
> 
> Leaving the switching function enabled did result in mmc timeouts and rcu
> stalls thus hanging the system on 3.19-rc1. Therefore disable it in all cases,
> as we expect the devicetree to explicitly select either mmc or jtag pinmuxes
> anyway.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks, applied.


-Olof
