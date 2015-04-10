From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 10 Apr 2015 17:15:11 +0200
Subject: [REGRESSION] commit 0461a41 "spi: Pump transfers inside
 calling context for spi_sync()" breaks Apalis/Colibri T30 with MCP2515
 SPI CAN controller
In-Reply-To: <20150410132330.GH6023@sirena.org.uk>
References: <1428670853.7008.87.camel@localhost.localdomain>
 <20150410132330.GH6023@sirena.org.uk>
Message-ID: <5527E8FF.7050104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2015 03:23 PM, Mark Brown wrote:
> On Fri, Apr 10, 2015 at 03:00:53PM +0200, Marcel Ziswiler wrote:
>> Hi there
> 
> Please try to use somewhat more targetted CC lists...
> 
>> I also have not yet looked further into what exactly is happening and
>> whether or not the SPI stack, the Tegra SPI controller driver or the
>> MCP2515 SPI CAN driver is to blame but rather decided to ask Mr. Brown
>> and the community first for any insights they might have to share.
>> Anybody?
> 
> I'd ask for trace logs but obviously we can't turn them on until boot
> has finished...  Adding some trace in the relevant bits of code to try
> to see where it's deadlocking is the obvious first step.

FWIW: the mcp2515 driver is accessing the SPI bus during probe(). Seems
you have to instrument the SPI stack and/or host driver.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/72bebd48/attachment.sig>
