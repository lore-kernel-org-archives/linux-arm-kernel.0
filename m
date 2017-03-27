From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 27 Mar 2017 16:14:32 +0100
Subject: [PATCH 0/7] memory: atmel-ebi: Add PM ops
In-Reply-To: <e27d2dd0-ce23-d63d-04dc-7be745770a00@atmel.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
 <e27d2dd0-ce23-d63d-04dc-7be745770a00@atmel.com>
Message-ID: <20170327151432.ybb3pfuxivdhb7ji@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Mar 2017, Nicolas Ferre wrote:

> Le 16/03/2017 ? 09:30, Boris Brezillon a ?crit :
> > Hello,
> > 
> > This patchset adds a ->resume() hook to the EBI driver, but a few more
> > changes were required in order to easily implement this PM hook.
> > 
> > Patches 1 to 5 are just cleanup patches to simplify the EBI driver.
> > Patch 6 is fixing a bug in the EBI driver. Note that this bug has no
> > consequences until we start implementing the ->resume() hook.
> > And finally, patch 7 is implementing ->resume() so that the SMC config
> > is correctly restored when resuming the system.
> > 
> > This patchset depends on [1] which is removing the unused pata_at91
> > driver, which in turn prevents us from patching it before dropping
> > the old SMC macro definitions in patch 4.
> > 
> > Regards,
> > 
> > Boris
> > 
> > [1]http://lkml.iu.edu/hypermail/linux/kernel/1702.2/00990.html
> 
> For the whole v2 series:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Lee, you can take this series through your MFD tree as suggested by Boris.

There doesn't appear to be a Maintainer for the memory subsystem.

Who is the Maintainer for drivers/memory/atmel-ebi.c?

If it's you, would you care to add an entry to MAINTAINERS?

> > Changes since v1:
> > - move helper functions in a C file
> > - check if tdf is at least ATMEL_SMC_MODE_TDF_MIN
> > 
> > Boris Brezillon (7):
> >   mfd: syscon: atmel-smc: Add new helpers to ease SMC regs manipulation
> >   memory: atmel-ebi: Simplify SMC config code
> >   memory: atmel-ebi: Stop using reg_field objects for simple things
> >   mfd: syscon: atmel-smc: Remove unused helpers/macros
> >   memory: atmel-ebi: Change naming scheme
> >   memory: atmel-ebi: Add missing ->numcs assignment
> >   memory: atmel-ebi: Add PM ops
> > 
> >  drivers/memory/Kconfig               |   1 +
> >  drivers/memory/atmel-ebi.c           | 584 ++++++++++++-----------------------
> >  drivers/mfd/Kconfig                  |   4 +
> >  drivers/mfd/Makefile                 |   1 +
> >  drivers/mfd/atmel-smc.c              | 314 +++++++++++++++++++
> >  include/linux/mfd/syscon/atmel-smc.h | 237 ++++++--------
> >  6 files changed, 606 insertions(+), 535 deletions(-)
> >  create mode 100644 drivers/mfd/atmel-smc.c
> > 
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
