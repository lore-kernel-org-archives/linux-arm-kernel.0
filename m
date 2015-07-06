From: fugang.duan@freescale.com (Duan Andy)
Date: Mon, 6 Jul 2015 01:26:30 +0000
Subject: [PATCH v2 0/2] Implement sample time consideration for Vybrid's
 ADC
In-Reply-To: <cover.1435134626.git.maitysanchayan@gmail.com>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
Message-ID: <BLUPR03MB37345F397DFF130F8FAFC58F5930@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sanchayan Maity <maitysanchayan@gmail.com> Sent: Wednesday, June 24, 2015 4:34 PM
> To: jic23 at kernel.org
> Cc: shawn.guo at linaro.org; kernel at pengutronix.de; robh+dt at kernel.org;
> pawel.moll at arm.com; mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; Duan Fugang-B38611; devicetree at vger.kernel.org;
> linux-iio at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; stefan at agner.ch; Sanchayan Maity
> Subject: [PATCH v2 0/2] Implement sample time consideration for Vybrid's
> ADC
> 
> Hello,
> 
> This patchset adds a dt binding for specifying sample time for the vybrid
> adc driver and takes this into account for sampling frequency calculation
> and related configuration in the driver.
> 
> The patchset is based on top of Stefan's patches here
> http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html
> 
> which got recently applied. Tested with shawn's for-next branch.
> 
> Changes since v1:
> 
> Change from a vendor specific fsl,min-sample-time to non vendor specific
> min-sample-time.
> 
> Version 1 of the patchset can be found here
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html
> 
> - Sanchayan.
> 
> Sanchayan Maity (2):
>   iio: adc: Determine sampling frequencies by using minimum sample time
>   ARM: dts: vfxxx: Add property for minimum sample time
> 
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
>  arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
>  drivers/iio/adc/vf610_adc.c                        | 74
> ++++++++++++++++++++--
>  3 files changed, 78 insertions(+), 4 deletions(-)

The patch set looks fine. Thanks Sanchayan add this new interface for user that is more options for user case.

Acked-by: Fugang Duan <B38611@freescale.com>
