From: monstr@monstr.eu (Michal Simek)
Date: Wed, 12 Mar 2014 11:01:44 +0100
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <531F0636.4050608@pengutronix.de>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD2C4.5060109@pengutronix.de>
 <f1e2f08f-05fc-40d3-8437-4c6817d631cb@AM1EHSMHS010.ehs.local>
 <531F0636.4050608@pengutronix.de>
Message-ID: <53203088.2070605@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 01:48 PM, Marc Kleine-Budde wrote:
> On 03/11/2014 01:34 PM, Appana Durga Kedareswara Rao wrote:
> 
>>>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig index
>>>> 9e7d95d..b180239 100644
>>>> --- a/drivers/net/can/Kconfig
>>>> +++ b/drivers/net/can/Kconfig
>>>> @@ -125,6 +125,13 @@ config CAN_GRCAN
>>>>       endian syntheses of the cores would need some modifications on
>>>>       the hardware level to work.
>>>>
>>>> +config CAN_XILINXCAN
>>>> +   tristate "Xilinx CAN"
>>>> +   depends on ARCH_ZYNQ || MICROBLAZE
>>>
>>> Is Zynq multiarch already?
>> Discussions are going on this
>> So the final thing that Fengguang ( fengguang.wu at intel.com)
>> Proposed is
>>         config CAN_XILINX
>>         tristate "Xilinx CAN"
>>         depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
>>         depends on COMMON_CLK && HAS_MMIO  # whatever you need for other architectures
> 
>> Are you Ok for this?
> 
> You have to fill the 2nd depends on with some sane values, though.

This should be that one
config CAN_XILINX
         tristate "Xilinx CAN"
         depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
         depends on COMMON_CLK && HAS_IOMEM


Is there any driver which is in CAN which not use MMIO accesses?
If not, maybe we should just add dependency to

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/ac875dcd/attachment.sig>
