From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Oct 2017 11:12:45 +0200
Subject: [PATCH v3 05/10] arm: dts: mt7623: update pio, usb and crypto
 nodes
In-Reply-To: <1508464539.13396.6.camel@mtkswgap22>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
 <08d722e47b83bd70ed4d3c9a4546a3f70df96de4.1506908511.git.ryder.lee@mediatek.com>
 <8c823070-7181-97cc-063e-3ced59c7e17d@gmail.com>
 <1508464539.13396.6.camel@mtkswgap22>
Message-ID: <1c26168e-af36-eb1c-22d8-8d4ffdf84d8d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/20/2017 03:55 AM, Ryder Lee wrote:
> Hi
> 
> On Thu, 2017-10-19 at 18:29 +0200, Matthias Brugger wrote:
>>
>> On 10/02/2017 03:54 AM, Ryder Lee wrote:
>>> This patch updates pio, usb and crypto nodes to make them be consistent
>>> with the binding documents.
>>>
>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>> ---
>>>  arch/arm/boot/dts/mt7623.dtsi | 26 ++++++++++++++------------
>>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
>>> index 381843e..0640fb7 100644
>>> --- a/arch/arm/boot/dts/mt7623.dtsi
>>> +++ b/arch/arm/boot/dts/mt7623.dtsi
>>> @@ -227,8 +227,7 @@
>>>  	};
>>>  
>>>  	pio: pinctrl at 10005000 {
>>> -		compatible = "mediatek,mt7623-pinctrl",
>>> -			     "mediatek,mt2701-pinctrl";
>>> +		compatible = "mediatek,mt7623-pinctrl";
>>
>> Looks good.
>>
>>>  		reg = <0 0x1000b000 0 0x1000>;
>>>  		mediatek,pctl-regmap = <&syscfg_pctl_a>;
>>>  		pins-are-numbered;
>>> @@ -680,7 +679,7 @@
>>>  		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
>>>  		clocks = <&hifsys CLK_HIFSYS_USB0PHY>,
>>>  			 <&topckgen CLK_TOP_ETHIF_SEL>;
>>> -		clock-names = "sys_ck", "free_ck";
>>> +		clock-names = "sys_ck", "ref_ck";
>>
>> This is already merged. Please rebase.
> 
> I didn't see any changes in mt7623.dtsi.
> 

You are right, sorry I didn't noticed this.

>>>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
>>>  		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
>>>  		status = "disabled";
>>> @@ -690,8 +689,6 @@
>>>  		compatible = "mediatek,mt7623-u3phy",
>>>  			     "mediatek,mt2701-u3phy";
>>>  		reg = <0 0x1a1c4000 0 0x0700>;
>>> -		clocks = <&clk26m>;
>>> -		clock-names = "u3phya_ref";
>>
>> Same here.
>>
>>>  		#address-cells = <2>;
>>>  		#size-cells = <2>;
>>>  		ranges;
>>> @@ -699,12 +696,16 @@
>>>  
>>>  		u2port0: usb-phy at 1a1c4800 {
>>>  			reg = <0 0x1a1c4800 0 0x0100>;
>>> +			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
>>> +			clock-names = "ref";
>>
>> Same here.
>>
>>>  			#phy-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>>  
>>>  		u3port0: usb-phy at 1a1c4900 {
>>>  			reg = <0 0x1a1c4900 0 0x0700>;
>>> +			clocks = <&clk26m>;
>>> +			clock-names = "ref";
>>
>> Same here.
>>
>>>  			#phy-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>> @@ -719,7 +720,7 @@
>>>  		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
>>>  		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
>>>  			 <&topckgen CLK_TOP_ETHIF_SEL>;
>>> -		clock-names = "sys_ck", "free_ck";
>>> +		clock-names = "sys_ck", "ref_ck";
>>
>> Same here.
>>
>>>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
>>>  		phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
>>>  		status = "disabled";
>>> @@ -729,8 +730,6 @@
>>>  		compatible = "mediatek,mt7623-u3phy",
>>>  			     "mediatek,mt2701-u3phy";
>>>  		reg = <0 0x1a244000 0 0x0700>;
>>> -		clocks = <&clk26m>;
>>> -		clock-names = "u3phya_ref";
>>
>> Same here.
>>
>>>  		#address-cells = <2>;
>>>  		#size-cells = <2>;
>>>  		ranges;
>>> @@ -738,12 +737,16 @@
>>>  
>>>  		u2port1: usb-phy at 1a244800 {
>>>  			reg = <0 0x1a244800 0 0x0100>;
>>> +			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
>>> +			clock-names = "ref";
>>
>> Same here.
>>
>>>  			#phy-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>>  
>>>  		u3port1: usb-phy at 1a244900 {
>>>  			reg = <0 0x1a244900 0 0x0700>;
>>> +			clocks = <&clk26m>;
>>> +			clock-names = "ref";
>>
>> Same here.
>>
>>>  			#phy-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>> @@ -784,16 +787,15 @@
>>>  	};
>>>  
>>>  	crypto: crypto at 1b240000 {
>>> -		compatible = "mediatek,mt7623-crypto";
>>> +		compatible = "mediatek,eip97-crypto";
>>
>> Crypto node is not present in upstream.
> 
> Crypto driver is already merged. 
> 

You are right, the node got added. I've overseen this as well :-\

After sleeping over this patch, I would prefer that you split it in three, one
for each device.
Thanks,
Matthias
