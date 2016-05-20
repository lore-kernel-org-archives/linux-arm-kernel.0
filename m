From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 20 May 2016 23:19:52 +0200
Subject: [PATCH] arm64: dts: rockchip: fixes the gic400 2nd region size
 for rk3368
In-Reply-To: <1463582510-29156-1-git-send-email-wxt@rock-chips.com>
References: <1463582510-29156-1-git-send-email-wxt@rock-chips.com>
Message-ID: <2773450.t8WTDyMWXy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 18. Mai 2016, 22:41:50 schrieb Caesar Wang:
> The 2nd additional region is the GIC virtual cpu interface register
> base and size.
> 
> As the gic400 of rk3368 says, the cpu interface register map as below
> 
> 
> 
> -0x0000 GICC_CTRL
> .
> .
> .
> -0x00fc GICC_IIDR
> -0x1000 GICC_IDR
> 
> Obviously, the region size should be greater than 0x1000.
> So we should make sure to include the GICC_IDR since the kernel will
> access it in some cases.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org

applied to a fixes branch for 4.7 with Shawn's review-tag.


Thanks for catching this
Heiko
