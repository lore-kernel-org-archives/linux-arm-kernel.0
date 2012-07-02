From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 21:08:38 +0200
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <20120702183330.GG1348@lunn.ch>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702183330.GG1348@lunn.ch>
Message-ID: <20120702210838.37c78fda@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

Le Mon, 2 Jul 2012 20:33:30 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> What physical address does this come out to? All Orion platforms have
> the serial port at the same place, 0xf1012000. If 370/XP is the same,
> i suggest dropping this #include, hard code the address, and we share
> the implementation for all SoCs. 
> 
> If however, the ASIC engineers have decided to move it, we need some
> extra logic to handle different base addresses for Dove and 370/XP
> which should be supportable in one kernel binary.

As per armada-370-xp.h:

#define ARMADA_370_XP_REGS_PHYS_BASE    0xd0000000

The physical address of the internal registers is 0xd0000000. It does
not seem to be configurable using the address decoding mechanism.

OMAP has some logic to handle this kind of problems, see
plat-omap/include/plat/uncompress.h. We can quite certainly overcome
this problem somehow.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
