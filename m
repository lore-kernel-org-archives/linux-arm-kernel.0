From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 13 Dec 2011 18:34:27 +0000
Subject: [PATCH] arm,davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <201112081548.08548.arnd@arndb.de>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <4EE07E27.8090602@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6040CBB@DBDE01.ent.ti.com>
 <201112081548.08548.arnd@arndb.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B60471C1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Dec 08, 2011 at 21:18:08, Arnd Bergmann wrote:
> On Thursday 08 December 2011, Nori, Sekhar wrote:
> > DaVinci AEMIF is an async memory interface peripheral implemented
> > in arch/arm/mach-davinci/aemif.c. It helps interface to NAND, NOR
> > and other asynchronous memories. Currently it just provides an API
> > for timing value configuration. The API is invoked by the MTD NAND
> > driver.
> > 
> > Specification here: http://www.ti.com/lit/ug/sprue20c/sprue20c.pdf
> > 
> > We are looking at a place for this outside of architecture code.
> 
> I think the best place depends on how you plan to use the sram
> interface. If all memory behind the aemif is handled by mtd, I would
> put the entire driver somewhere in the mtd infrastructure.

All the boards and use cases I have come across for AEMIF so far
(5-6 years) have either used NAND or NOR memory.

> If you want it to provide endpoint devices that are handled by
> distinct subsystems in Linux, I would make it an mfd multifunction
> device and make the common code a driver that scans the connected
> memories in order to register its child devices for each of the
> subsystems.

Okay. Thanks for the explanation. Since the users of AEMIF at this
point are mtd devices, I propose moving it to drivers/mtd/davinci-aemif.c
(of course, mtd folks need to approve).

Thanks,
Sekhar
