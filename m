From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Apr 2015 14:23:30 +0100
Subject: [REGRESSION] commit 0461a41 "spi: Pump transfers inside calling
 context for spi_sync()" breaks Apalis/Colibri T30 with MCP2515 SPI CAN
 controller
In-Reply-To: <1428670853.7008.87.camel@localhost.localdomain>
References: <1428670853.7008.87.camel@localhost.localdomain>
Message-ID: <20150410132330.GH6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 03:00:53PM +0200, Marcel Ziswiler wrote:
> Hi there

Please try to use somewhat more targetted CC lists...

> I also have not yet looked further into what exactly is happening and
> whether or not the SPI stack, the Tegra SPI controller driver or the
> MCP2515 SPI CAN driver is to blame but rather decided to ask Mr. Brown
> and the community first for any insights they might have to share.
> Anybody?

I'd ask for trace logs but obviously we can't turn them on until boot
has finished...  Adding some trace in the relevant bits of code to try
to see where it's deadlocking is the obvious first step.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/fbcffabf/attachment.sig>
