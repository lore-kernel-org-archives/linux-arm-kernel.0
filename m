From: monstr@monstr.eu (Michal Simek)
Date: Mon, 28 Jul 2014 11:18:05 +0200
Subject: [PATCH v2] ARM: zynq: DT: Add CAN node
In-Reply-To: <20140725150017.GE16049@xsjandreislx>
References: <56bf20294d106e0fc9c23a70cd991a50b441d0aa.1406271138.git.michal.simek@xilinx.com>
 <20140725150017.GE16049@xsjandreislx>
Message-ID: <53D6154D.3060107@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 05:00 PM, S?ren Brinkmann wrote:
> On Fri, 2014-07-25 at 08:52AM +0200, Michal Simek wrote:
>> Add node describing Zynq's CAN controller.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Add can1
>> - Enable can0 for zc702
>> - Use status property
>>
>>  arch/arm/boot/dts/zynq-7000.dtsi | 26 +++++++++++++++++++++++++-
>>  arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 366ca6434f54..983148111e3a 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -71,7 +71,31 @@
>>  			interrupts = <0 7 4>;
>>  			interrupt-parent = <&intc>;
>>  			clocks = <&clkc 12>;
>> -		};
>> +		};
>> +
>> +		can0: can at e0008000 {
>> +			compatible = "xlnx,zynq-can-1.0";
>> +			status = "disabled";
>> +			clocks = <&clkc 19>, <&clkc 36>;
>> +			clock-names = "can_clk", "pclk";
>> +			reg = <0xe0008000 0x1000>;
>> +			interrupts = <0 28 4>;
>> +			interrupt-parent = <&intc>;
>> +			tx-fifo-depth = <0x40>;
>> +			rx-fifo-depth = <0x40>;
>> +		};
>> +
>> +		can1: can at e0009000 {
>> +			compatible = "xlnx,zynq-can-1.0";
>> +			status = "disabled";
>> +			clocks = <&clkc 19>, <&clkc 36>;
> The clocks for CAN1 must be outputs 20 and 37 of the clkc.

Fixed in v3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/a1e9978d/attachment.sig>
