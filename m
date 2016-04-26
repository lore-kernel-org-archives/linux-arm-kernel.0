From: s.christ@phytec.de (Stefan Christ)
Date: Tue, 26 Apr 2016 09:51:28 +0200
Subject: [PATCH v2] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <1461587712-16403-1-git-send-email-mpa@pengutronix.de>
References: <1461587712-16403-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20160426075128.GC2351@lws-christ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 25, 2016 at 02:35:12PM +0200, Markus Pargmann wrote:
> ECC is only calculated for written pages. As erased pages are not
> actively written the ECC is always invalid. For this purpose the
> Hardware BCH unit is able to check for erased pages and does not raise
> an ECC error in this case. This behaviour can be influenced using the
> BCH_MODE register which sets the number of allowed bitflips in an erased
> page. Unfortunately the unit is not capable of fixing the bitflips in
> memory.
> 
> To avoid complete software checks for erased pages, we can simply check
> buffers with uncorrectable ECC errors because we know that any erased
> page with errors is uncorrectable by the BCH unit.
> 
> This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
> to correct erased pages. To have the valid data in the buffer before
> using them, this patch moves the read_page_swap_end() call before the
> ECC status checking for-loop.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> [Squashed patches by Stefan and Boris to check ECC area]
> Cc: Stefan Christ <s.christ@phytec.de>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Tested-by: Stefan Christ <s.christ@phytec.de>

I verified the fix again on our board.

Mit freundlichen Gr??en / Kind regards,
	Stefan Christ
