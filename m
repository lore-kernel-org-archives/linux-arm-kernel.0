From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 09:07:16 +0000
Subject: [PATCH v3 7/9] arm: mach-mvebu: add compilation/configuration
 change
In-Reply-To: <20120615075644.GI26034@lunn.ch>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-8-git-send-email-gregory.clement@free-electrons.com>
 <20120615075644.GI26034@lunn.ch>
Message-ID: <201206150907.16872.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Andrew Lunn wrote:
> How is this going to work when we move DT supported kirkwood, Orion5x,
> Dove, etc into here?
> 
> Maybe this should be called ARCH_MVEBU_CPU_V7 for these two SoCs plus
> Dove and we have a second config ARCH_MVEBU_CPU_V5 for Kirkwood,
> Orion5x, MV78xx0?

I think having one top-level option is fine, we can make sure you
only select compatible ones inside the merged Kconfig, e.g.

config ARCH_ORION5X
	bool "Marvell Orion"
	depends on !CPU_V7
	select CPU_V5

config ARCH_KIRKWOOD
	bool "Marvell Kirkwood"
	depends on !CPU_V7
	select CPU_V5

config ARCH_DOVE
	bool "Marvell Dove"
	select CPU_V7

config ARCH_ARMADA370
	bool Marvell Armada 370"
	select CPU_V7

config ARCH_ARMADAXP
	bool Marvell ArmadaXP"
	select CPU_V7


	Arnd
