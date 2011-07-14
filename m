From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2011 17:22:19 +0200
Subject: [PATCH v3 0/6] ARM: make mach/hardware.h optional
In-Reply-To: <1310489612-8625-1-git-send-email-robherring2@gmail.com>
References: <1310489612-8625-1-git-send-email-robherring2@gmail.com>
Message-ID: <201107141722.19407.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Rob Herring wrote:
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
> I've compile tested on most affected ARM platforms. 
> 
> Changes from v2:
> - Incorporated compile fixes for microblaze from Michal Simek.
> - Added conversion of powerpc to generic pci flag functions.
> - Combined powerpc and microblaze conversion to use 
>   asm-generic/pci-bridge.h into one commit. Renaming of powerpc pci
>   flags functions is separate commit.
> - Changed defaults for PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM to 0x1000 and
>   0x1000000, respectively.
> - Dropped commit moving ARCH_HAS_DMA_SET_COHERENT_MASK defines into 
>   memory.h. This conflicts with other clean-up work by Nicolas Pitre.

Looks good to me, I'll apply it as soon as I hear back from Russell.

Russell, do you have an opinion on the changes to arch/arm/{include,lib} ?

	Arnd
