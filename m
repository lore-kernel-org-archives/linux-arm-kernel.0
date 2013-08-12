From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Aug 2013 11:28:04 +0100
Subject: Build error: versatile express
Message-ID: <20130812102804.GD23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down.clone.0':
arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here

This is caused by the assembly code in this file clobbering R11, which
is incompatible with having CONFIG_FRAME_POINTER=y.
