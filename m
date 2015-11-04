From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 14:41:12 +0000
Subject: [PATCH v2 2/5] spi: spi-ti-qspi: add mmap mode read support
In-Reply-To: <1446545174-14193-3-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-3-git-send-email-vigneshr@ti.com>
Message-ID: <20151104144112.GJ1717@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:36:11PM +0530, Vignesh R wrote:

> +	ti_qspi_enable_memory_map(spi);
> +	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
> +				dummy_bytes);
> +	memcpy_fromio(buf, qspi->mmap_base + from, len);
> +	*retlen = len;
> +	ti_qspi_disable_memory_map(spi);

We'll be constantly enabling and disabling memory mapping with this.
I'm not sure that's a meaningful cost given that it doesn't actually
remap anything but rather just switches hardware modes, we can always
optimise it later if it is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/2ec01951/attachment.sig>
