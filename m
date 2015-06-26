From: rogerq@ti.com (Roger Quadros)
Date: Fri, 26 Jun 2015 10:33:05 +0300
Subject: [PATCH 1/1] arm: dts: am43xx-clock: Add qspi clock node.
In-Reply-To: <558CEF2E.3050202@ti.com>
References: <1435167933-5249-1-git-send-email-mugunthanvnm@ti.com>
 <558CEF2E.3050202@ti.com>
Message-ID: <558D0031.1090501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/15 09:20, Keerthy wrote:
>
>
> On Wednesday 24 June 2015 11:15 PM, Mugunthan V N wrote:
>> From: Sourav Poddar <sourav.poddar@ti.com>
>>
>> Add clock node for qspi controller driver on am437x.
>>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi        | 2 ++
>>   arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi
>> b/arch/arm/boot/dts/am4372.dtsi
>> index 649e7b9..8ab7831 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -903,6 +903,8 @@
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>>               ti,hwmods = "qspi";
>> +            clocks = <&qspi_fclk>;
>> +            clock-names = "fck";
>>               interrupts = <0 138 0x4>;
>>               num-cs = <4>;
>>               status = "disabled";
>> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> index cc88728..1506585 100644
>> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> @@ -763,4 +763,12 @@
>>           ti,bit-shift = <8>;
>>           reg = <0x8a68>;
>>       };
>> +
>> +    qspi_fclk: qspi_fclk {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,fixed-factor-clock";
>> +        clocks = <&dpll_per_m2_div4_ck>;
>
>  From the clock tree this does not seem to be sourced from dpll_per_m2.
> I guess this needs to be changed.

Right. We need to have a mux and divider.

cheers,
-roger

>
>> +        clock-mult = <1>;
>> +        clock-div = <1>;
>> +    };
>>   };
>>
