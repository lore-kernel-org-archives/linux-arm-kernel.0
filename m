From: menschel.p@posteo.de (Patrick Menschel)
Date: Tue, 4 Apr 2017 18:54:35 +0200
Subject: [PATCH v3 1/4] ARM: dts: sun4i: Add CAN node
In-Reply-To: <20170404154018.6phu2udfgwuzklkk@lukather>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-2-git-send-email-menschel.p@posteo.de>
 <20170404154018.6phu2udfgwuzklkk@lukather>
Message-ID: <a92644d4-6fbd-fc0f-6369-d97e7f46a738@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.04.2017 um 17:40 schrieb Maxime Ripard:
> On Mon, Apr 03, 2017 at 07:00:11PM +0200, Patrick Menschel wrote:
>> The A10 SoC has an on-board CAN controller.
>> This patch adds the device node.
>>
>> This patch is adapted from the description in
>> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>>
>> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
>> ---
>>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index ba20b48..7c559e7 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -1313,6 +1313,14 @@
>>  			#size-cells = <0>;
>>  		};
>>  
>> +		can0: can at 01c2bc00 {
>> +			compatible = "allwinner,sun4i-a10-can";
>> +			reg = <0x01c2bc00 0x400>;
>> +			interrupts = <26>;
>> +			clocks = <&apb1_gates 4>;
>> +			status = "disabled";
>> +		};
>> +
> This wasn't ordered properly. Fixed and applied.
>
>
Now that you mention it, ps20 and ps21 do not follow follow the rising
address order.

        uart7: serial at 01c29c00 {
            ...
        i2c0: i2c at 01c2ac00 {
            ...
        i2c1: i2c at 01c2b000 {
            ...
        i2c2: i2c at 01c2b400 {
            ...
        can0: can at 01c2bc00 {
            ...
        ps20: ps2 at 01c2a000 {
            ....
        ps21: ps2 at 01c2a400 {
            ...
       
The correct order would be
uart7, ps20, ps21, i2c0, i2c1, i2c2, can0 .

I'll fix that in patch v4.

Thanks,
Patrick

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3709 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/8cb04d6b/attachment.p7s>
