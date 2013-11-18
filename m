From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 13:39:40 +0000
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <20131118093229.GB13640@lee--X1>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
 <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaccxcTfKc-y7rPEH1H3yua3ubLvuvTzWnMs1rOwjiVNw@mail.gmail.com>
 <20131118093229.GB13640@lee--X1>
Message-ID: <20131118133940.GC14306@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 09:32:29AM +0000, Lee Jones wrote:

> I've actually travelled down the route of separating the SPI
> Controller parts to drivers/spi. It's possible to do that and perhaps
> we could then use the generic m25p80 Serial Flash driver as the
> back-end, but it would be incredibly complicated and would mean we'd
> need to duplicate almost all of the m25p80 driver into the SPI
> Controller. The Falcon SPI driver tried to do something similar, but
> now looks broken due to some incompatible changes in m25p80. We also
> want to avoid putting ourselves in that position of fragility.

What I've said to people doing similar drivers before is that it seems
like there should be an abstraction added in the MTD framework for SPI
flash controllers like this is that if there is genunie flash-specific
stuff going on then the mp25p80 driver ought to be split so that the
code that understands what commands to send to the flash chip is split
out from the code that actually sends those commands to the chip.  The
existing SPI support would then be a function driver for this.  This
would mean we don't need to support the flash chips multiple times.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/d3234a26/attachment.sig>
