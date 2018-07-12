From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 09:19:59 +0200
Subject: [PATCH] mmc: sunxi: Use new timing mode for A64 eMMC controller
In-Reply-To: <20180712030225.15681-1-wens@csie.org>
References: <20180712030225.15681-1-wens@csie.org>
Message-ID: <20180712071959.fi4rhgwv2iuoelbl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
> The eMMC controller is also a new timing mode controller, but it doesn't
> have the timing mode switch. It does however have signal delay and
> calibration controls, typical of Allwinner MMC controllers that support
> the new timing mode.
> 
> Enable the new timing mode setting for the A64 eMMC controller. This
> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> chips that support it, and can deliver such throughput.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

That doesn't look right. The datasheet explicitly mentions that this
bit doesn't apply to the eMMC controller, and the BSP is doing the same:
https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c

vs
https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c

And I definitely remember having HS-DDR working back when I added the
a64 eMMC support.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/438c9ea8/attachment.sig>
