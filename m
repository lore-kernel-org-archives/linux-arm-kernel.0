From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Jul 2015 19:17:45 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <1438072876-16338-2-git-send-email-vigneshr@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
Message-ID: <20150731181745.GM20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:11:12PM +0530, Vignesh R wrote:

> Introduce use_mmap_read field in spi_message struct. This can be set by
> mtd devices (m25p80) to indicate to spi-master (ti-qspi) to perform
> memory mapped read. This helps to distinguish whether the spi-message is
> from mtd layer(hence mmap read is possible) or by other spi devices.

Based on this description and...

> + * @use_mmap_mode: Indicate to spi master to perform memory mapped
> + *	read if possible.

...the internal documentation I unable to tell what is meant by "perform
a memory mapped read", at least to the extent where it is visible
outside of the driver.  This means we can't really use this as a generic
API since other people won't be able to tell what it does.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/879cfeaf/attachment.sig>
