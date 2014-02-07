From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Feb 2014 09:31:04 +0100
Subject: [PATCH 19/21] ARM: MVEBU: Simplifiy headers and make local
In-Reply-To: <1391730137-14814-20-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-20-git-send-email-andrew@lunn.ch>
Message-ID: <20140207093104.7197224d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri,  7 Feb 2014 00:42:15 +0100, Andrew Lunn wrote:
> kirkwood is very nearly fully DT. Remove most of the address
> definitions from the header files and make it a local header file.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/include/mach/bridge-regs.h |  85 ---------------
>  arch/arm/mach-mvebu/include/mach/kirkwood.h    | 142 -------------------------
>  arch/arm/mach-mvebu/kirkwood-pm.c              |   2 +-
>  arch/arm/mach-mvebu/kirkwood.c                 |   2 +-
>  arch/arm/mach-mvebu/kirkwood.h                 |  22 ++++
>  5 files changed, 24 insertions(+), 229 deletions(-)
>  delete mode 100644 arch/arm/mach-mvebu/include/mach/bridge-regs.h
>  delete mode 100644 arch/arm/mach-mvebu/include/mach/kirkwood.h
>  create mode 100644 arch/arm/mach-mvebu/kirkwood.h

Is there any particular reason why this isn't part of PATCH 14/21. I
was very surprised when reading PATCH 14/21 to see a file named
"bridge-regs.h" containing Kirkwood-specific definitions added to
mach-mvebu, and so many address constants being defined, while we are
DT-based only in mach-mvebu.

> +#define KIRKWOOD_REGS_PHYS_BASE	0xf1000000
> +#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
> +#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)
> +
> +#define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
> +
> +#define CPU_CONFIG_PHYS		(BRIDGE_PHYS_BASE + 0x0100)
> +#define CPU_CONFIG_ERROR_PROP	0x00000004
> +
> +#define CPU_CONTROL_PHYS	(BRIDGE_PHYS_BASE + 0x0104)
> +#define MEMORY_PM_CTRL_PHYS	(BRIDGE_PHYS_BASE + 0x0118)

Are there plans to also get rid of those constants at some point?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
