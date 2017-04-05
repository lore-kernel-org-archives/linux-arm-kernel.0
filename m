From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 5 Apr 2017 15:33:09 +0800
Subject: [PATCH 2/3] arm64: allwinner: a64: add USB0 OHCI/EHCI related
 devicetree parts
In-Reply-To: <20170405072631.ou4e5gafvagwpykq@lukather>
References: <20170404184518.33610-1-icenowy@aosc.io>
 <20170404184518.33610-2-icenowy@aosc.io>
 <20170405071508.yaur35xuli4jgkfb@lukather>
 <7828ffa0-f570-9841-a9e6-fe175f8169ac@aosc.io>
 <20170405072631.ou4e5gafvagwpykq@lukather>
Message-ID: <a4ca2175-b4df-42e4-1f85-20d34430d4dc@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?04?05? 15:26, Maxime Ripard ??:
> On Wed, Apr 05, 2017 at 03:17:19PM +0800, Icenowy Zheng wrote:
>>
>>
>> ? 2017?04?05? 15:15, Maxime Ripard ??:
>>> On Wed, Apr 05, 2017 at 02:45:17AM +0800, Icenowy Zheng wrote:
>>>> As we added USB0 route auto switching support for A64, add related
>>>> device tree parts to the A64 DTSI file (EHCI0/OHCI0 controllers and the
>>>> pmu0 memory area for PHY).
>>>>
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> index 1c64ea2d23f9..a8916df99048 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> @@ -179,8 +179,10 @@
>>>>  		usbphy: phy at 01c19400 {
>>>>  			compatible = "allwinner,sun50i-a64-usb-phy";
>>>>  			reg = <0x01c19400 0x14>,
>>>> +			      <0x01c1a800 0x4>,
>>>>  			      <0x01c1b800 0x4>;
>>>>  			reg-names = "phy_ctrl",
>>>> +				    "pmu0",
>>>
>>> This breaks the older DTs, and that property isn't documented.
>>
>> It's already documented.
>>
>> In the H3 dual-route patchset I have already added this.
>>
>> ("  * "pmu0" for H3, V3s and A64")
>
> This is not in linux-next then, sorry.

It's already in next-20160405.

>
>> P.S. to be compatible with older DTs, I think I should adjust
>> the phy driver, make it enable dual-route function only when
>> pmu0 is present.
>
> That, or if we're quick enough, we can still add it to 4.11. There's a
> bit of time left.

Thus the device tree binding patch and the DT part of this patchset
should be all pushed to 4.11 .

The device tree binding patch is commit ee73fd7dfc86 ("dt: bindings: add 
pmu0 regs for USB PHYs on Allwinner H3/V3s/A64").

>
> Maxime
>
