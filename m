From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Wed, 3 Jun 2015 10:10:59 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1427300909-20825-2-git-send-email-stefan@agner.ch>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
Message-ID: <20150603081059.GA6944@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-25 17:28:24 [+0100], Stefan Agner wrote:
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> new file mode 100644
> index 0000000..23c1510
> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c
?
> +static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
> +{
> +	if (column != -1) {
> +		if (nfc->chip.options | NAND_BUSWIDTH_16)
> +			column = column/2;
> +		vf610_nfc_set_field(nfc, NFC_COL_ADDR, COL_ADDR_MASK,
> +				    COL_ADDR_SHIFT, column);
> +	}
> +	if (page != -1)
> +		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
> +				    ROW_ADDR_SHIFT, page);
> +}

Do you have here also a different NAND layout on your boot-page vs
remaining pages? The mpc5125 has this different layout.

Sebastian
