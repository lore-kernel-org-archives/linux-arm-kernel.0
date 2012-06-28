From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Jun 2012 16:50:51 -0400 (EDT)
Subject: [PATCH] ARM: Orion: Fix WDT compile for Dove and MV78xx0
In-Reply-To: <1340915288-22437-1-git-send-email-andrew@lunn.ch>
References: <1340915288-22437-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.02.1206281647010.31003@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jun 2012, Andrew Lunn wrote:

> Commit 0fa1f0609a0c1fe8b2be3c0089a2cb48f7fda521 (ARM: Orion: Fix
> Virtual/Physical mixup with watchdog) broke the Dove & MV78xx0
> build. Although these two SoC don't use the watchdog, the shared
> platform code still needs to build. Add the necessary defines.
> 
> Reported-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

With this patch applied on top of commit ccce27c0fe (mainline as of 10 
minutes ago):

$ make dove_defconfig && make zImage
[...]
  CC      arch/arm/plat-orion/common.o 
arch/arm/plat-orion/common.c:585:3: error: 'BRIDGE_PHYS_BASE' undeclared here (not in a function)
make[1]: *** [arch/arm/plat-orion/common.o] Error 1


Nicolas
