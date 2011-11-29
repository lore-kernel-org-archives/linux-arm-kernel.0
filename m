From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Nov 2011 17:16:59 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <20111129170013.GD2829@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <20111129170013.GD2829@localhost.localdomain>
Message-ID: <1322587019.3164.111.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-29 at 17:00 +0000, Dave Martin wrote:
> I'm trying to build... what tree are you basing on?

v3.2-rc3:

$ git log --oneline HEAD...v3.2-rc3~
3b9df1e ARM: vexpress: DT-based support for CoreTiles Express A5x2 and A9x4
5a1c565 ARM: vexpress: Initial RS1 memory map support
9355e8a ARM: vexpress: Add DT support in v2m
0529bd6 ARM: vexpress: Get rid of MMIO_P2V
68118cc ARM: versatile: Add missing ENDPROC to headsmp.S
caca6a0 Linux 3.2-rc3

> With v3.2-rc3 or next, I get OF header failures like the following:
> 
> arch/arm/kernel/devtree.c: In function ?arm_dt_memblock_reserve?:
> arch/arm/kernel/devtree.c:41:7: error: ?initial_boot_params? undeclared (first use in this function)
> arch/arm/kernel/devtree.c:41:7: note: each undeclared identifier is reported only once for each function it appears in
[...]

Can you send me your config, please?

Also, I forgot to mention that you need Rob's "of/irq: of_irq_init: add
check for parent equal to child
node" (http://article.gmane.org/gmane.linux.kernel/1221051) to get this
working.

Cheers!

Pawe?
