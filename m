From: leoyang.li@nxp.com (Leo Li)
Date: Tue, 3 Oct 2017 16:38:54 +0000
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <AM5PR0402MB2691BFAD9ABB649BE3C0DE9AEC720@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
 <AM5PR0402MB2691BFAD9ABB649BE3C0DE9AEC720@AM5PR0402MB2691.eurprd04.prod.outlook.com>
Message-ID: <AM4PR0401MB169995A82BB3DEA3B28450E58F720@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Madalin-cristian Bucur
> Sent: Tuesday, October 03, 2017 4:55 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm at kernel.org; linux-arm-kernel at lists.infradead.org; Catalin Marinas
> <catalin.marinas@arm.com>; Roy Pledge <roy.pledge@nxp.com>; Arnd
> Bergmann <arnd@arndb.de>
> Subject: RE: [GIT PULL] updates to soc/fsl drivers for v4.14
> 
> Hi Leo,
> 
> Should we include the Reviewed-by tags in the pull request commits logs?

I have already included Catalin's Reviewed-by in the git log for patches he replied with a Reviewed-by.  There are a few patches that are not related to ARM architecture don't have his reviewed-by, which I think is fine.

Leo

> 
> Madalin
> 
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li at nxp.com]
> > Sent: Friday, September 22, 2017 10:37 PM
> > To: arm at kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas
> > <catalin.marinas@arm.com>; Roy Pledge <roy.pledge@nxp.com>; Arnd
> > Bergmann <arnd@arndb.de>; Madalin-cristian Bucur
> > <madalin.bucur@nxp.com>
> > Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
> >
> > Hi arm-soc maintainers,
> >
> > This pull request includes updates to the QMAN/BMAN drivers to make
> > them work on the arm/arm64 architectures in addition to the power
> > architecture and a few minor update/bug-fix to the soc/fsl drivers.
> >
> > We got the Reviewed-by from Catalin on the ARM architecture side.
> >
> > DPAA (Data Path Acceleration Architecture) is a set of hardware
> > components used on some FSL/NXP QorIQ Networking SoCs, it provides the
> > infrastructure to support simplified sharing of networking interfaces
> > and accelerators by multiple CPU cores, and the accelerators
> > themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
> > infrastructural components within the DPAA framework.  They are used
> > to manage queues and buffers for various I/O interfaces, hardware
> > accelerators.
> >
> > More information can be found via link:
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.n
> xp.
> > com%2Fproducts%2Fmicrocontrollers-and-processors%2Fpower-architecture-
> > processors%2Fqoriq-platforms%2Fdata-path-
> >
> acceleration%3AQORIQ_DPAA&data=01%7C01%7Cmadalin.bucur%40nxp.com%
> 7Ca38
> > 4d00
> >
> a91714cf5710808d501f161da%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&
> sdata
> > =e2a
> > XiPCt%2FwQbTr6JafKqGzTjSdDv4qNUizPVDKPcRQw%3D&reserved=0
> >
> > Regards,
> > Leo
> >
> >
> > The following changes since commit
> > 0a8abd97dcda50e5d2c893a51733416534e95706:
> >
> >   Merge tag 'for-linus-4.14b-rc2-tag' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2017-09-22
> > 06:40:47
> > -1000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > tags/soc-
> > fsl-for-4.14
> >
> > for you to fetch changes up to e868adf21c0a25634d5dfa5b1e6dbf839306d8fa:
> >
> >   soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM (2017-09-22
> > 13:33:07
> > -0500)
> >
> > ----------------------------------------------------------------
> > FSL/NXP ARM SoC drivers updates for 4.14
> >
> > This adds the DPAA QBMan support for ARM SoCs and a few minor
> > fixes/updates.
> >
> > ----------------------------------------------------------------
> > Claudiu Manoil (2):
> >       soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
> >       soc/fsl/qbman: Add missing headers on ARM
> >
> > Karim Eshapa (1):
> >       soc/fsl/qman: Sleep instead of stuck hacking jiffies
> >
> > Madalin Bucur (4):
> >       soc/fsl/qbman: Drop set/clear_bits usage
> >       soc/fsl/qbman: add QMAN_REV32
> >       soc/fsl/qbman: different register offsets on ARM
> >       soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM
> >
> > Roy Pledge (5):
> >       soc/fsl/qbman: Add common routine for QBMan private allocations
> >       soc/fsl/qbman: Use shared-dma-pool for BMan private memory
> > allocations
> >       soc/fsl/qbman: Use shared-dma-pool for QMan private memory
> > allocations
> >       dt-bindings: soc/fsl: Update reserved memory binding for QBMan
> >       soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
> >
> > Valentin Rothberg (1):
> >       soc/fsl/qbman: Fix ARM32 typo
> >
> > ashish kumar (1):
> >       soc/fsl/guts: Add compatible string for LS1088
> >
> >  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +--
> > Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++--
> >  drivers/soc/fsl/guts.c                             |  1 +
> >  drivers/soc/fsl/qbman/Kconfig                      |  2 +-
> >  drivers/soc/fsl/qbman/Makefile                     |  2 +-
> >  drivers/soc/fsl/qbman/bman.c                       | 42 ++++++++--
> >  drivers/soc/fsl/qbman/bman_ccsr.c                  | 15 ++++
> >  drivers/soc/fsl/qbman/bman_portal.c                | 23 +++---
> >  drivers/soc/fsl/qbman/bman_priv.h                  |  8 +-
> >  drivers/soc/fsl/qbman/dpaa_sys.c                   | 78
> > ++++++++++++++++++
> >  drivers/soc/fsl/qbman/dpaa_sys.h                   | 25 ++++--
> >  drivers/soc/fsl/qbman/qman.c                       | 83 +++++++++++++----
> > --
> >  drivers/soc/fsl/qbman/qman_ccsr.c                  | 95 +++++++++++++++--
> > -----
> >  drivers/soc/fsl/qbman/qman_portal.c                | 23 +++---
> >  drivers/soc/fsl/qbman/qman_priv.h                  | 11 +--
> >  drivers/soc/fsl/qbman/qman_test.h                  |  2 -
> >  16 files changed, 320 insertions(+), 128 deletions(-)  create mode
> > 100644 drivers/soc/fsl/qbman/dpaa_sys.c
