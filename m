From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 16:38:30 +0000
Subject: [PATCH 1/6] spi: imx: specify spi base for device tree probe
In-Reply-To: <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20121109163830.GP23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:00:20PM +0100, Steffen Trumtrar wrote:

> * This breaks compatibility with user space applications between non-DT and DT.

> * On platforms that are in between DT and non-DT, it breaks registration of
>   devices via spi_board_info.

> Use the same method as 7e6086d9e54a159a6257c02bb7fc5805c614aad2 does for gpios:
> Use alias to identify the spi port, and then specify the base via the port id.
> If alias is not defined in DT, allocate the base dynamically.

This sounds like a fix userspace and/or complete your DT conversion
problem...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/deb6a538/attachment.sig>
