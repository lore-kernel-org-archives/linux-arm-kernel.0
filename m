From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 19 Jun 2014 18:55:04 +0530
Subject: [PATCH v2 13/18] ARM: dts: dra7xx-clocks: Add missing clocks
 for second PCIe PHY instance
In-Reply-To: <53A2C787.5060905@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-14-git-send-email-kishon@ti.com> <53A2C787.5060905@ti.com>
Message-ID: <53A2E4B0.7030204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 19 June 2014 04:50 PM, Tero Kristo wrote:
> On 05/29/2014 09:38 AM, Kishon Vijay Abraham I wrote:
>> Added missing clocks used by second instance of PCIe PHY.
>> The documention for this nodes can be found @ ../bindings/clock/ti/gate.txt.
> 
> Drop the ref to the binding doc and rather add a ref to TRM about the clock
> layout. Also, is the register offset wrong on these? Should be 0x13b8, no, or
> is my TRM version wrong?

Er.. you are right. It should be 0x13b8.

Thanks
Kishon
> 
> -Tero
> 
>>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7xx-clocks.dtsi |   24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> index 3d8c9c2..a9ff0dc 100644
>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> @@ -1173,6 +1173,14 @@
>>           ti,bit-shift = <8>;
>>       };
>>
>> +    optfclk_pciephy2_32khz: optfclk_pciephy_32khz at 4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&sys_32k_ck>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <8>;
>> +    };
>> +
>>       optfclk_pciephy_div: optfclk_pciephy_div at 4a00821c {
>>           compatible = "ti,divider-clock";
>>           clocks = <&apll_pcie_ck>;
>> @@ -1191,6 +1199,14 @@
>>           ti,bit-shift = <9>;
>>       };
>>
>> +    optfclk_pciephy2_clk: optfclk_pciephy_clk at 4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&apll_pcie_ck>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <9>;
>> +    };
>> +
>>       optfclk_pciephy1_div_clk: optfclk_pciephy_div_clk at 4a0093b0 {
>>           compatible = "ti,gate-clock";
>>           clocks = <&optfclk_pciephy_div>;
>> @@ -1199,6 +1215,14 @@
>>           ti,bit-shift = <10>;
>>       };
>>
>> +    optfclk_pciephy2_div_clk: optfclk_pciephy_div_clk at 4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&optfclk_pciephy_div>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <10>;
>> +    };
>> +
>>       apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
>>           #clock-cells = <0>;
>>           compatible = "fixed-factor-clock";
>>
> 
