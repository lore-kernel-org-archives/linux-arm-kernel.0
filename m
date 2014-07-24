From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 24 Jul 2014 08:44:59 +0200
Subject: [PATCH] ARM: zynq: DT: Add CAN node
In-Reply-To: <20140723160702.GA14564@xsjandreislx>
References: <52d799e17cd3539713625c6f6a6666620f52d692.1406120732.git.michal.simek@xilinx.com>
 <20140723160702.GA14564@xsjandreislx>
Message-ID: <2fe3a869-d17c-4521-a5c1-7c347ae34726@BN1BFFO11FD060.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2014 06:07 PM, S?ren Brinkmann wrote:
> On Wed, 2014-07-23 at 03:05PM +0200, Michal Simek wrote:
>> Add node describing Zynq's CAN controller.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm/boot/dts/zynq-7000.dtsi | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 366ca6434f54..2287d9b4ed1a 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -71,7 +71,18 @@
>>  			interrupts = <0 7 4>;
>>  			interrupt-parent = <&intc>;
>>  			clocks = <&clkc 12>;
>> -		};
>> +		};
>> +
>> +		can0: can at e0008000 {
>> +			compatible = "xlnx,zynq-can-1.0";
>> +			clocks = <&clkc 19>, <&clkc 36>;
>> +			clock-names = "can_clk", "pclk";
>> +			reg = <0xe0008000 0x1000>;
>> +			interrupts = <0 28 4>;
>> +			interrupt-parent = <&intc>;
>> +			tx-fifo-depth = <0x40>;
>> +			rx-fifo-depth = <0x40>;
>> +		};
> 
> What about the second CAN core? You also probably want to add
> 'status = "disabled"' in the dtsi.

Second can core - yes.

I can add status = "disabled" but then question is if make
sense to change status for any zynq dts file. Or just
keep enable both.

In our repo is enabled can0 on zc702.

What do you think?

Thanks,
Michal
