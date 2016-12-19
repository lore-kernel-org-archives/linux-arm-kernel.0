From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Dec 2016 16:39:54 +0100
Subject: [PATCH] ARM: dts: imx: Pass an empty 'chosen' node
In-Reply-To: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
References: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20161219153954.5tntppc6a7bfqjyh@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 01:28:18PM -0200, Fabio Estevam wrote:
> Commit 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi") causes boot
> issues when the bootloader does not create a 'chosen' node if such node
> is not present in the dtb.
> 
> The reason for the boot failure is well explained by Javier Martinez
> Canillas: "the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info."
> 
> , so pass an empty 'chosen' node to fix the boot problem.
> 
> This issue has been seen in the kernelci reports with Barebox as
> bootloader.
> 
> Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

There is also a patch on the barebox list that makes barebox fix a dt
accordingly. It seems it's not in the repository though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
