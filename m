From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 14:45:12 +0000
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <20131118142447.GJ13640@lee--X1>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
 <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaccxcTfKc-y7rPEH1H3yua3ubLvuvTzWnMs1rOwjiVNw@mail.gmail.com>
 <20131118093229.GB13640@lee--X1>
 <20131118133940.GC14306@sirena.org.uk>
 <20131118142447.GJ13640@lee--X1>
Message-ID: <20131118144512.GB24408@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 02:24:47PM +0000, Lee Jones wrote:

> For example, we have thought about inserting a layer which handles the
> type of communication that'll be utilised i.e. true SPI, or our
> bespoke FSM implementation for instance. This would enable us to issue
> serial_flash_write(), serial_flash_write_then_read(), ... in the m25p80
> driver and not care which protocol is used. However, in reality this
> won't really save a great deal of code - not in our case at least.

Right, that's what I'm suggesting.  It's not so much for the code saving
as for the data saving, allowing device trees that just say "flash chip
X is connected" rather than requiring either the flash chip information
in multiple places in the kernel or (worse) have the commands added to
the DTs of individual boards using the flash chip.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/f8f71139/attachment.sig>
