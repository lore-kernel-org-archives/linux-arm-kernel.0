From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 Jun 2011 19:24:22 -0400 (EDT)
Subject: [RFC PATCH 0/4] ARM: make mach/hardware.h optional
In-Reply-To: <1309301859-17651-1-git-send-email-robherring2@gmail.com>
References: <1309301859-17651-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.00.1106281919310.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jun 2011, Rob Herring wrote:

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

Excellent !  This is certainly moving things in the right direction.

For the 4 patches, you can add:

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Obviously for patch 1/4 it would be nice to have the opinion of the PCI 
maintainer as well.


Nicolas
