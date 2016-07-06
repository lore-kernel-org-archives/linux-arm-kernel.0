From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 06 Jul 2016 22:56:34 +0200
Subject: [PATCH v3] arm64: dts: rockchip: add the power domain node for
 rk3399
In-Reply-To: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
References: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
Message-ID: <4362000.pLfftZqEvu@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. Juli 2016, 20:34:04 schrieb Caesar Wang:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> In order to meet low power requirements, a power management unit (PMU) is
> designed for controlling power resources in RK3399. The RK3399 PMU is
> dedicated for managing the power of the whole chip.
> 
> 1. add pd node for RK3399 Soc
> 2. create power domain tree
> 3. add qos node for domain
> 
> From the DT/binds and driver can get more detail information:
> The driver:
>         drivers/soc/rockchip/pm_domains.c
> The document:
>         Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> Note:
> As the TRM lists many voltage domains and power domains, then this patch
> adds some domains for driver. Due to some domains
> (e.g. emmc, usb, core)...We can't turned off it on
> bootup, or says some device driver can't handle the power domain enough.
> Maybe We will add more other domains in the future or later.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: Heiko Stuebner <heiko@sntech.de>

applied to my dts64 branch after renaming the qos nodes, removing the status
property and moving the rga domain up a bit. Please double check:
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=6d3cdbf1c219f9817290903e9d1e8de7462a7b54
