From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 05 Jul 2010 11:52:24 -0000
Subject: [patch 0/2] ARM: Disable outer cache before kexec call -V3
Message-ID: <20100705113029.082013074@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series addresses the problem that the kexec code
does not disable the outer cache before disabling the inner cache and
jumping into the new kernel. This results in random crashes of the new
kernel.

Changes since version 2:

 - Use CLEAN_INV_WAY in l2x0_flush_all according to Catalin

 - Rename outer_cache_disable() to outer_disable()

 - Added a  BUG_ON() when l2x0_inv_all() is called with L2 enabled.

Thanks,

	tglx
