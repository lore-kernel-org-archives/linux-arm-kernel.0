From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Sep 2017 20:28:53 +0300
Subject: [PATCH 10/11] arm64: dts: renesas: initial Eagle board device tree
In-Reply-To: <d6f9d5ef-4864-3ffb-9406-acd65bff10aa@cogentembedded.com>
References: <20170912210543.810219167@cogentembedded.com>
 <d6f9d5ef-4864-3ffb-9406-acd65bff10aa@cogentembedded.com>
Message-ID: <5c680bad-39c8-a6c7-ee2a-6a2e72c33026@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2017 12:19 AM, Sergei Shtylyov wrote:

>> Add the initial device  tree for  the R8A77970 SoC based Eagle board.
>> The board has 1 debug serial port (SCIF0); include support for it,
>> so that the serial console can work.
>>
>> Based on the original (and large) patch by Vladimir Barinov
>> <vladimir.barinov@cogentembedded.com>.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
> [...]
>> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> ===================================================================
>> --- /dev/null
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> @@ -0,0 +1,45 @@
> [...]
>> +&extal_clk {
>> +    clock-frequency = <16666666>;
>> +};
>> +
>> +&extalr_clk {
>> +    clock-frequency = <32768>;
>> +};
>> +
> 
>     Forgot to specify SCIF_CLK -- it's populated.

    Unfortunately, the kernel hangs after ttySC0 is registered if I specify 
this frequency...

MBR, Sergei
