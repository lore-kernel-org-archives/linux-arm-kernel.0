From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Mon, 8 Dec 2014 15:09:29 +0000
Subject: [PATCH v7 0/5] ARM64: Add support for FSL's LS2085A SoC
References: <1417443442-17444-1-git-send-email-bhupesh.sharma@freescale.com>
 <20141201163013.GA22708@leverpostej>
Message-ID: <BY1PR0301MB13032F9A5B59585272458F3C82640@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm Maintainers,

Its been some time since I posted v7 of this series.

If there are no other reviews comments on the series, can this be pulled into
the ARM SoC tree (arm-soc.git) for merge.

> -----Original Message-----
> From: Sharma Bhupesh-B45370
> Sent: Tuesday, December 02, 2014 1:26 AM
> To: 'Mark Rutland'
> Cc: arm at kernel.org; Marc Zyngier; Catalin Marinas; arnd at arndb.de; linux-
> arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> rob.herring at linaro.org; bhupesh.linux at gmail.com; Yoder Stuart-B08248;
> arnab_basu at rocketmail.com
> Subject: RE: [PATCH v7 0/5] ARM64: Add support for FSL's LS2085A SoC
> 
> Hi Mark,
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: Monday, December 01, 2014 10:00 PM
> > To: Sharma Bhupesh-B45370
> > Cc: arm at kernel.org; Marc Zyngier; Catalin Marinas; arnd at arndb.de;
> > linux- arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> > rob.herring at linaro.org; bhupesh.linux at gmail.com; Yoder Stuart-B08248;
> > arnab_basu at rocketmail.com
> > Subject: Re: [PATCH v7 0/5] ARM64: Add support for FSL's LS2085A SoC
> >
> > Hi Bhupesh,
> >
> > The series looks mostly fine to me, though I have a couple of comments
> > below.
> >
> > On Mon, Dec 01, 2014 at 02:17:17PM +0000, Bhupesh Sharma wrote:
> > > This patchset adds the support for FSL's LS2085A SoC which is based
> > > on
> > > ARMv8 architecture.
> > >
> > > This patchset also has patches which address DT compatible strings
> > > for nodes which appear un-documented.
> > >
> > > The enable-method for the CPU nodes is left for the bootloader
> > > (u-boot or UEFI) to patch-up which is expected to be PSCI v0.2
> > >
> > > This patchset has been tested with the following patches which add
> > > PSCI
> > > v0.2 support in ARMv8 u-boot:
> > > http://patchwork.ozlabs.org/patch/383556/
> > > http://patchwork.ozlabs.org/patch/383555/
> > > http://patchwork.ozlabs.org/patch/383557/
> > > http://patchwork.ozlabs.org/patch/383558/
> > > http://patchwork.ozlabs.org/patch/383559/
> > > http://patchwork.ozlabs.org/patch/383560/
> > > http://patchwork.ozlabs.org/patch/383561/
> > > http://patchwork.ozlabs.org/patch/383562/
> >
> > Has there been any progress on these? last I saw there was some
> > pending rework, and I was holding off a thorough review of the PSCI
> > parts until that had happened.
> 
> Arnab Basu has since moved on from Freescale, but he plans to maintain
> and rework these PSCI related patches in u-boot.
> 
> >
> > >
> > > Rebased against cleanup/dts-subdirs branch of the arm-soc tree
> > >
> > > Changes from v6:
> > > ----------------
> > > * Rebased against cleanup/dts-subdirs branch of the arm-soc tree.
> > > * As a result, [PATCH 4/6] and [PATCH 5/6] of the v6 series are
> > squashed
> > >   into one patch ([PATCH 4/5] of this series).
> > >
> > > Note:
> > > -----
> > > Optional GIC-500 regs like GICC, GICH and GICV are currently not
> > > tested and hence are not part of the DTS patch.
> > >
> > > Please review and consider for merge.
> > >
> > > Bhupesh Sharma (5):
> > >   Documentation: DT: Add bindings for FSL NS16550A UART
> >
> > Regardless of anything else, this patch should be queued given it adds
> > missing documentation for a binding already supported by the kernel.
> 
> Right.
> 
> > >   Documentation: DT: Add entry for FSL LS2085A SoC and Simulator
> model
> > >   Documentation: DT: Add entry for FSL Management Complex
> >
> > Are there any patches adding support for the management complex?
> > There's nothing in mainline that uses "fsl,qoriq-mc", and nothing in
> > this series adds support.
> >
> 
> Like Stuart mentioned in another thread, the Management Complex related
> patches are already under review.
> 
> >
> > >   arm64: Add DTS support for FSL's LS2085A SoC
> > >   arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig
> > >
> > >  Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
> > >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40 +++++
> > >  .../devicetree/bindings/serial/of-serial.txt       |   12 ++
> > >  arch/arm64/Kconfig                                 |    5 +
> > >  arch/arm64/boot/dts/Makefile                       |    1 +
> > >  arch/arm64/boot/dts/{ => freescale}/Makefile       |    4 +-
> > >  arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts |   65 ++++++++
> > >  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  163
> > ++++++++++++++++++++
> > >  arch/arm64/configs/defconfig                       |    1 +
> > >  9 files changed, 296 insertions(+), 3 deletions(-)  create mode
> > > 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > >  copy arch/arm64/boot/dts/{ => freescale}/Makefile (54%)  create
> > > mode
> > > 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > >
> > > --
> > > 1.7.9.5
> > >
> 
> Regards,
> Bhupesh

Regards,
Bhupesh
