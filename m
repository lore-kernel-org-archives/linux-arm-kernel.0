From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Mar 2011 14:08:44 +0100
Subject: [PATCH V7 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110321130844.GG9686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 01:22:16PM +0800, Richard Zhu wrote:
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

I am still wondering if one of the fixes could be handled at core level,
but I don't have hardware to test. But I may be wrong, so this is good
enough for now to go in IMO.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110321/7accab93/attachment.sig>
