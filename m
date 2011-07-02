From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 2 Jul 2011 11:24:46 +0200
Subject: [PATCH v2 0/6] ARM: make mach/hardware.h optional
In-Reply-To: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
Message-ID: <201107021124.46953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 June 2011 18:46:53 Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Currently, all ARM platforms must have a mach/hardware.h include. This is
> because it is ultimately included by linux/pci.h which is included in many
> places even for !CONFIG_PCI.
> 
> This could be fixed simply with an ifdef around the include of mach/hardware.h
> in asm/pci.h. However, in the interest of fixing this for single kernel
> binary builds, this series removes the include of mach/hardware.h outside of
> mach-* and plat-*. What's used from hardware.h is a couple of PCI defines. 
> Converting them to variables allows each platform to set the values as needed.
> 
> This does not address the inclusion of mach/hardware.h under drivers/*. This
> appears to be mostly older platforms. There could also be some indirect
> inclusions from other mach/* headers.
> 

Hi Rob,

This is very good work, I really like it. I've mentioned one idea for
an improvement in patch 5, which you can still integrate, but otherwise

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

for the whole series.

Thanks,

	Arnd
