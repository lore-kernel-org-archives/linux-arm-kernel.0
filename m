From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 20 Mar 2014 04:41:56 +0000
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <53203088.2070605@monstr.eu>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD2C4.5060109@pengutronix.de>
 <f1e2f08f-05fc-40d3-8437-4c6817d631cb@AM1EHSMHS010.ehs.local>
 <531F0636.4050608@pengutronix.de> <53203088.2070605@monstr.eu>
Message-ID: <45bec219-6349-4bcf-be8a-7ee1dfd1bcb9@TX2EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> -----Original Message-----
> From: Michal Simek [mailto:monstr at monstr.eu]
> Sent: Wednesday, March 12, 2014 3:32 PM
> To: Marc Kleine-Budde
> Cc: Appana Durga Kedareswara Rao; linux-can at vger.kernel.org;
> netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; robh+dt at kernel.org;
> grant.likely at linaro.org; Michal Simek; wg at grandegger.com;
> fengguang.wu at intel.com
> Subject: Re: [PATCH v5] can: xilinx CAN controller support.
>
> On 03/11/2014 01:48 PM, Marc Kleine-Budde wrote:
> > On 03/11/2014 01:34 PM, Appana Durga Kedareswara Rao wrote:
> >
> >>>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> >>>> index
> >>>> 9e7d95d..b180239 100644
> >>>> --- a/drivers/net/can/Kconfig
> >>>> +++ b/drivers/net/can/Kconfig
> >>>> @@ -125,6 +125,13 @@ config CAN_GRCAN
> >>>>       endian syntheses of the cores would need some modifications on
> >>>>       the hardware level to work.
> >>>>
> >>>> +config CAN_XILINXCAN
> >>>> +   tristate "Xilinx CAN"
> >>>> +   depends on ARCH_ZYNQ || MICROBLAZE
> >>>
> >>> Is Zynq multiarch already?
> >> Discussions are going on this
> >> So the final thing that Fengguang ( fengguang.wu at intel.com) Proposed
> >> is
> >>         config CAN_XILINX
> >>         tristate "Xilinx CAN"
> >>         depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> >>         depends on COMMON_CLK && HAS_MMIO  # whatever you need for
> >> other architectures
> >
> >> Are you Ok for this?
> >
> > You have to fill the 2nd depends on with some sane values, though.
>
> This should be that one
> config CAN_XILINX
>          tristate "Xilinx CAN"
>          depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
>          depends on COMMON_CLK && HAS_IOMEM
>
>
> Is there any driver which is in CAN which not use MMIO accesses?
> If not, maybe we should just add dependency to



Can you please comment on this?
I had update driver with all the other comments I had a little confusion regarding
Which Kconfig options I need to use.

Regards,
Kedar.


> Thanks,
> Michal
>
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture Microblaze U-
> BOOT custodian and responsible for u-boot arm zynq platform
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
