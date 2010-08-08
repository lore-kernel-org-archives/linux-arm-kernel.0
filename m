From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Aug 2010 09:19:56 +0100
Subject: [PATCH 6/8] mxc_nand: fix correct_data function
In-Reply-To: <1281102791-8089-7-git-send-email-s.hauer@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<1281102791-8089-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100808081955.GB8687@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 03:53:09PM +0200, Sascha Hauer wrote:
> +		err = ecc_stat & ecc_bit_mask;
> +		if (err > err_limit) {
> +			printk(KERN_WARNING "UnCorrectable RS-ECC Error\n");
> +			return -1;

Someone's being lazy.
