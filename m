From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 12 Jan 2011 20:25:42 +0800
Subject: [PATCH] mxcmmc: use dmaengine API
In-Reply-To: <1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
	<1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110112122541.GA6569@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems all the tabs were turned into spaces.

On Wed, Jan 12, 2011 at 11:09:56AM +0100, Sascha Hauer wrote:
> This switches the mxcmmc driver to use the dmaengine API. Unlike
> the old one this one is always present in the tree, even if no DMA
> is implement, hence we can remove all the #ifdefs in from the driver.
> The driver automatically switches to PIO mode if no DMA support or no
> suitable channel is available.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/mxcmmc.c |  172 +++++++++++++++++++++++++--------------------
>  1 files changed, 97 insertions(+), 75 deletions(-)
> 
[...]

-- 
Regards,
Shawn
