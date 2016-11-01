From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 02 Nov 2016 00:25:37 +0100
Subject: [PATCH] clk: rockchip: optimize the configuration for 800MHz and
 1GHz on RK3399
In-Reply-To: <1477970526-26388-1-git-send-email-zhengxing@rock-chips.com>
References: <1477970526-26388-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <37901081.P92AxpVH96@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. November 2016, 11:22:06 CET schrieb Xing Zheng:
> Usually, the 800MHz and 1GHz are supplied for CPLL and NPLL in the RK3399.
> But dues to the carelessly copying from RK3036 when the RK3399 bringing up,
> the refdiv == 6, it will increase the lock time, and it is not an optimal
> configuration.
> 
> Please let's fix them for the lock time and jitter are lower:
> 800 MHz:
> - FVCO == 2.4 GHz, revdiv == 1.
> 1 GHz:
> - FVCO == 3 GHz, revdiv == 1.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-branch for 4.10


Thanks
Heiko
