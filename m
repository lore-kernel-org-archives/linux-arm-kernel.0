From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 21 May 2017 16:42:08 +0800
Subject: [PATCH] ARM: dts: imx7s-warp: Pass 'no-1-8-v' property to the eMMC
In-Reply-To: <1495047325-6010-1-git-send-email-fabio.estevam@nxp.com>
References: <1495047325-6010-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170521084207.GH26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 03:55:25PM -0300, Fabio Estevam wrote:
> Currently the following eMMC error is seen:
> 
> mmc1: mmc_select_hs200 failed, error -74
> mmc1: new MMC card at address 0001
> mmcblk1: mmc1:0001 V10008 7.05 GiB
> mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
> 
> On imx7s-warp the eMMC VCCQ is fixed at 3.15V, so pass the 'no-1-8-v'
> property to properly describe that 1.8V operation is not possible.
> 
> With this change HS200 error is gone and another benefit is that the
> card can operate in DDR52 mode now:
> 
> mmc1: new DDR MMC card at address 0001
> mmcblk1: mmc1:0001 V10008 7.05 GiB
> mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
