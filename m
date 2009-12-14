From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 14 Dec 2009 23:04:20 +0800
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091214135722.CBCBF4C026@gemini.denx.de>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>
	<20091211234714.GT28375@buzzloop.caiaq.de>
	<20091214135722.CBCBF4C026@gemini.denx.de>
Message-ID: <20091214150420.GE28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 02:57:22PM +0100, Wolfgang Denk wrote:
> I don't think this is a boot loader issue.
> 
> In Linux, the kernel hangs here:
> 
> 	/* read SREV register from IIM module */
> 	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
> 
> In U-Boot, I can read this register just fine:
> 
> 	=> md 5001c024 1
> 	5001c024: 00000028    (...
> 
> In Linux, the IO_ADDRESS() makes this a read from 0xFC11C024, which
> hangs.
> 
> So if this is a clock thing, then it must be a clock being disabled by
> Linux.

Well, clocks are explicitly enabled for that module, so I really don't
know. And I can't debug as I'm not at my office where the hardware is I
developed this on. Can anyone help check what's the matter? As I said,
on my MX31LiteKit, that works as expected and the register definition
reads as something that must have been there for a longer time (taking
into account that possible values for that register cover ancient
variants of that hardware).

As I said already, we could also consider reverting this patch - I'll
have another look and ask for more testers when I'm back. I would,
however, greatly prefer a fixup patch.

Daniel
