From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 13 Nov 2013 09:54:19 +0000
Subject: [PATCH 2/7] arm: dt: zynq: Add 'cpus' node
In-Reply-To: <d439357d-2451-405d-acf5-8514c50c779a@AM1EHSMHS002.ehs.local>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383945677-29674-3-git-send-email-soren.brinkmann@xilinx.com>
 <528128A8.9060400@arm.com>
 <91c27955-2d9f-4e85-8d9e-b8a178b76cdb@CO9EHSMHS026.ehs.local>
 <d439357d-2451-405d-acf5-8514c50c779a@AM1EHSMHS002.ehs.local>
Message-ID: <52834C4B.2080501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/13 21:58, S?ren Brinkmann wrote:
> On Tue, Nov 12, 2013 at 10:06:05AM -0800, S?ren Brinkmann wrote:
>> On Mon, Nov 11, 2013 at 06:57:44PM +0000, Sudeep KarkadaNagesha wrote:
>>> On 08/11/13 21:21, Soren Brinkmann wrote:
>>>> Add a 'cpus' node to describe the CPU cores of Zynq.
>>>>
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>>>> ---
>>>>  arch/arm/boot/dts/zynq-7000.dtsi | 27 +++++++++++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> index 27ebc1ba9671..37fc04525142 100644
>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> @@ -15,6 +15,33 @@
>>>>  / {
>>>>  	compatible = "xlnx,zynq-7000";
>>>>  
>>>> +	cpus {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		cpu at 0 {
>>>> +			compatible = "arm,cortex-a9";
>>>> +			device_type = "cpu";
>>>> +			reg = <0>;
>>>> +			clocks = <&clkc 3>;
>>>> +			i-cache-size = <0x8000>;
>>>> +			i-cache-line-size = <0x20>;
>>>> +			d-cache-size = <0x8000>;
>>>> +			d-cache-line-size = <0x20>;
>>>
>>> These cache properties can be identified through CCSIDR(Cache Size ID Registers)
>>> on ARMv7 Cortex implementations. It's better not to have these in DT if they can
>>> be identified runtime.
>> Sounds good to me. I'll go ahead an remove them.
> BTW: Documentation/devicetree/booting-without-of.txt lists those
> properties at least as recommended. That should probably be updated.
> 

Correct, thanks for pointing at that. IMO it definitely needs an update with
respect to ARM/ARM64. E.g. the cpu topology bindings for ARM is now @
Documentation/devicetree/bindings/arm/cpus.txt and
Documentation/devicetree/bindings/arm/topology.txt, the cache properties can be
determined runtime so not a required property.

This document looks more general and specifics may not be applicable everywhere.
More over specific bindings are getting defined for many sections in this document.

Regards,
Sudeep
