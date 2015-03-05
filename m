From: monstr@monstr.eu (Michal Simek)
Date: Thu, 05 Mar 2015 15:27:47 +0100
Subject: [PATCH v2] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <54F862BE.7000901@arm.com>
References: <cd616fa25dafee38f98e3b207e74450c5403f440.1425563597.git.michal.simek@xilinx.com>
 <54F862BE.7000901@arm.com>
Message-ID: <54F867E3.6070706@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/05/2015 03:05 PM, Marc Zyngier wrote:
> Hi Michal,
> 
> On 05/03/15 13:53, Michal Simek wrote:
>> Initial version of device tree for Xilinx ZynqMP SoC.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>
>> Changes in v2:
>> -  move timer out of amba_apu bus because it is not on bus
>>    Reported by Mark
>> - FIC GICC and GICV addresses - Reported by Rob
>> - Fix copyright
>> - Enable cadence IP in defconfig
>> - Add support for macb multiqueue
>>
>>  arch/arm64/Kconfig                          |   5 +
>>  arch/arm64/boot/dts/Makefile                |   1 +
>>  arch/arm64/boot/dts/xilinx/Makefile         |   5 +
>>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts |  47 +++++
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 303 ++++++++++++++++++++++++++++
>>  arch/arm64/configs/defconfig                |   3 +
>>  6 files changed, 364 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/Makefile
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> 
> [...]
> 
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
>> new file mode 100644
>> index 000000000000..0a3f40ecd06d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> 
> [...]
> 
>> +		gic: interrupt-controller at f9010000 {
>> +			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>> +			#interrupt-cells = <3>;
>> +			reg = <0x0 0xf9010000 0x10000>,
>> +			      <0x0 0xf902f000 0x2000>,
>> +			      <0x0 0xf9040000 0x20000>,
>> +			      <0x0 0xf906f000 0x2000>;
>> +			interrupt-controller;
> 
> Please add the missing GIC maintenance interrupt.

Ok. Will add interrupts = <1 9 0xf04>;

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/f478d746/attachment-0001.sig>
