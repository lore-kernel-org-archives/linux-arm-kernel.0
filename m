From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 25 Aug 2015 13:34:12 -0700
Subject: [PATCH v10 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1438594050-4595-2-git-send-email-stefan@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-2-git-send-email-stefan@agner.ch>
Message-ID: <20150825203412.GM81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing...

On Mon, Aug 03, 2015 at 11:27:26AM +0200, Stefan Agner wrote:
> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -0,0 +1,645 @@
...
> +struct vf610_nfc {
> +	struct mtd_info mtd;
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct completion cmd_done;
> +	uint buf_offset;
> +	int page_sz;

AFAICT (even with the 2nd patch), you never really use this field. You
just set it/increment it, but don't use it for anything. Kill it?

> +	/* Status and ID are in alternate locations. */
> +	int alt_buf;
> +#define ALT_BUF_ID   1
> +#define ALT_BUF_STAT 2
> +#define ALT_BUF_ONFI 3
> +	struct clk *clk;
> +};

Brian
