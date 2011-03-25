From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 25 Mar 2011 10:00:18 +0100
Subject: [PATCH V8 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <1301024346-2232-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1301024346-2232-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110325090018.GB3302@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 11:39:06AM +0800, Richard Zhu wrote:
> Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK
> read in SDIO on imx53.
> 
> The CMDTYPE of the CMD register (offset 0xE) should be set to
> "11" when the STOP CMD12 is issued on imx53 to abort one
> open ended multi-blk IO. Otherwise one the TC INT wouldn't
> be generated.
> 
> In exact block transfer, the controller doesn't complete the
> operations automatically as required at the end of the
> transfer and remains on hold if the abort command is not sent on
> imx53.
> As a result, the TC flag is not asserted and SW  received timeout
> exeception. set bit1 of Vendor Spec registor to fix it.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110325/da650a72/attachment.sig>
