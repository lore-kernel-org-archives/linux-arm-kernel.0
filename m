From: xuejiancheng@huawei.com (xuejiancheng)
Date: Mon, 14 Dec 2015 09:45:58 +0800
Subject: [PATCH v3 2/7] clk: hisilicon: add dt-binding document for Hi3519
 CRG
In-Reply-To: <20151211151909.GA21272@rob-hp-laptop>
References: <1449819921-18464-1-git-send-email-xuejiancheng@huawei.com>
 <1449819921-18464-3-git-send-email-xuejiancheng@huawei.com>
 <20151211151909.GA21272@rob-hp-laptop>
Message-ID: <566E1F56.3070800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/11 23:19, Rob Herring wrote:
> On Fri, Dec 11, 2015 at 03:45:16PM +0800, Jiancheng Xue wrote:
>> add dt-binding document for Hi3519 CRG block
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>> ---
>>  .../devicetree/bindings/clock/hi3519-crg.txt       | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hi3519-crg.txt b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
>> new file mode 100644
>> index 0000000..e0d30a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
>> @@ -0,0 +1,46 @@
>> +* Hisilicon Hi3519 Clock and Reset Generator(CRG)
>> +
>> +The Hi3519 CRG module provides clock and reset signals to various
>> +controllers within the SoC.
>> +
>> +This binding uses the following bindings:
>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +    Documentation/devicetree/bindings/reset/reset.txt
>> +
>> +Required Properties:
>> +
>> +- compatible: should be one of the following.
>> +  - "hisilicon,hi3519-crg" - controller compatible with Hi3519 SoC.
>> +
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +
>> +- #clock-cells: should be 1.
>> +
>> +Each clock is assigned an identifier and client nodes use this identifier
>> +to specify the clock which they consume.
>> +
>> +All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
> 
> This header should be part of this patch.

Because the header is also depended on by the clock driver. It's also a problem
if I separate it from the clock driver patch.

Is it OK if I put this binding file into the clock driver patch?
> 
>> +
>> +- #reset-cells: should be 2.
>> +
>> +A reset signal can be controlled by writing a bit register in the CRG module.
>> +The reset specifier consists of two cells. The first cell represents the
>> +register offset relative to the base address. The second cell represents the
>> +bit index in the register.
>> +
>> +Example: CRG nodes
>> +CRG: clock-reset-controller {
> 
> clock-reset-controller at 12010000

OK.

> 
>> +	compatible = "hisilicon,hi3519-crg";
>> +        reg = <0x12010000 0x10000>;
>> +        #clock-cells = <1>;
>> +        #reset-cells = <2>;
>> +};
>> +
>> +Example: consumer nodes
>> +i2c0: i2c at 0x12110000 {
> 
> Drop '0x'

OK.

> 
>> +	compatible = "hisilicon,hi3519-i2c";
>> +        reg = <0x12110000 0x1000>;
>> +        clocks = <&CRG HI3519_I2C0_RST>;*/
>> +        resets = <&CRG 0xE4 0>;
> 
> lowercase hex please

OK.

> 
>> +};
>> -- 
>> 1.9.1
>>
> 
> .
> 
