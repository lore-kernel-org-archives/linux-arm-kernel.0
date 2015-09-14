From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Sep 2015 19:27:04 +0100
Subject: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read
 request
In-Reply-To: <1441355402-6837-4-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-4-git-send-email-vigneshr@ti.com>
Message-ID: <20150914182704.GD12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 02:00:00PM +0530, Vignesh R wrote:

> +	if (spi->master->spi_mtd_mmap_read) {
> +		return  spi->master->spi_mtd_mmap_read(spi, from, len,
> +						       retlen, buf,
> +						       nor->read_opcode,
> +						       nor->addr_width,
> +						       dummy);
> +	}

We should be calling some API provided by the SPI core here, not peering
directly into the ops struture.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/58246eef/attachment-0001.sig>
