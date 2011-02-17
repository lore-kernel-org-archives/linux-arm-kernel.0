From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Feb 2011 16:18:44 +0100
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110217151223.GJ24627@n2100.arm.linux.org.uk>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<201102171541.12261.arnd@arndb.de>
	<20110217151223.GJ24627@n2100.arm.linux.org.uk>
Message-ID: <201102171618.44269.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 February 2011, Russell King - ARM Linux wrote:
> > Actually, for correctness you should use the regular readl/writel, not
> > the __raw_ versions, which can result in reordered or partial accesses
> > on the bus.
> 
> Not in the decompressor.  readl/writel are unsupported there - the
> decompressor doesn't have the L2 cache support code and so the barriers
> necessary for readl/writel cause link errors.

Ah right, of course. Sorry for the confusion.

	Arnd
