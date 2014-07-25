From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 08:47:05 +0200
Subject: [PATCH] ARM: zynq: DT: Add CAN node
In-Reply-To: <d973d7c8-30e7-458e-9d57-15da917cde04@BL2FFO11FD030.protection.gbl>
References: <52d799e17cd3539713625c6f6a6666620f52d692.1406120732.git.michal.simek@xilinx.com>
 <20140723160702.GA14564@xsjandreislx>
 <2fe3a869-d17c-4521-a5c1-7c347ae34726@BN1BFFO11FD060.protection.gbl>
 <d973d7c8-30e7-458e-9d57-15da917cde04@BL2FFO11FD030.protection.gbl>
Message-ID: <53D1FD69.4020109@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2014 05:55 PM, S?ren Brinkmann wrote:
> On Thu, 2014-07-24 at 08:44AM +0200, Michal Simek wrote:
>> On 07/23/2014 06:07 PM, S?ren Brinkmann wrote:
>>> On Wed, 2014-07-23 at 03:05PM +0200, Michal Simek wrote:
>>>> Add node describing Zynq's CAN controller.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>  arch/arm/boot/dts/zynq-7000.dtsi | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> index 366ca6434f54..2287d9b4ed1a 100644
>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> @@ -71,7 +71,18 @@
>>>>  			interrupts = <0 7 4>;
>>>>  			interrupt-parent = <&intc>;
>>>>  			clocks = <&clkc 12>;
>>>> -		};
>>>> +		};
>>>> +
>>>> +		can0: can at e0008000 {
>>>> +			compatible = "xlnx,zynq-can-1.0";
>>>> +			clocks = <&clkc 19>, <&clkc 36>;
>>>> +			clock-names = "can_clk", "pclk";
>>>> +			reg = <0xe0008000 0x1000>;
>>>> +			interrupts = <0 28 4>;
>>>> +			interrupt-parent = <&intc>;
>>>> +			tx-fifo-depth = <0x40>;
>>>> +			rx-fifo-depth = <0x40>;
>>>> +		};
>>>
>>> What about the second CAN core? You also probably want to add
>>> 'status = "disabled"' in the dtsi.
>>
>> Second can core - yes.
>>
>> I can add status = "disabled" but then question is if make
>> sense to change status for any zynq dts file. Or just
>> keep enable both.
>>
>> In our repo is enabled can0 on zc702.
>>
>> What do you think?
> 
> Well, it should be enabled on boards that have CAN pinned out. Does any
> of our boards have that?

I have checked and only can0 for zc702 should be enabled.

Let me send v2.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/30c2e4d5/attachment.sig>
