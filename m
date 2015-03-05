From: monstr@monstr.eu (Michal Simek)
Date: Thu, 05 Mar 2015 15:08:26 +0100
Subject: [PATCH v2] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <20150305150322.19e378d9@free-electrons.com>
References: <cd616fa25dafee38f98e3b207e74450c5403f440.1425563597.git.michal.simek@xilinx.com>
 <20150305150322.19e378d9@free-electrons.com>
Message-ID: <54F8635A.9020808@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 03/05/2015 03:03 PM, Thomas Petazzoni wrote:
> Dear Michal Simek,
> 
> On Thu,  5 Mar 2015 14:53:34 +0100, Michal Simek wrote:
> 
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <0 143 4>,
>> +			     <0 144 4>,
>> +			     <0 145 4>,
>> +			     <0 146 4>;
> 
> Any reason not to use
> 
> #include <dt-bindings/interrupt-controller/arm-gic.h>
> #include <dt-bindings/interrupt-controller/irq.h>
> 
> in order to write the more descriptive:
> 
> 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> 
> And ditto for all other interrupts properties?

I tend to not to use them because it is just hassle when I want
to move DTSes to different project.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/6483e80f/attachment.sig>
