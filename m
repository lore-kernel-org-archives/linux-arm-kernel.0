From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Sep 2017 21:53:02 +0300
Subject: [PATCH 10/11] arm64: dts: renesas: initial Eagle board device tree
In-Reply-To: <CAMuHMdU+DYBCu1bKLh_VjuSR-cSfjwPQuAxTsaU2JW-3d-5QUw@mail.gmail.com>
References: <20170912210543.810219167@cogentembedded.com>
 <d6f9d5ef-4864-3ffb-9406-acd65bff10aa@cogentembedded.com>
 <5c680bad-39c8-a6c7-ee2a-6a2e72c33026@cogentembedded.com>
 <CAMuHMdU+DYBCu1bKLh_VjuSR-cSfjwPQuAxTsaU2JW-3d-5QUw@mail.gmail.com>
Message-ID: <323063a2-1256-fa25-b91c-4c726ab277a2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2017 09:44 PM, Geert Uytterhoeven wrote:

>>>> Add the initial device  tree for  the R8A77970 SoC based Eagle board.
>>>> The board has 1 debug serial port (SCIF0); include support for it,
>>>> so that the serial console can work.
>>>>
>>>> Based on the original (and large) patch by Vladimir Barinov
>>>> <vladimir.barinov@cogentembedded.com>.
>>>>
>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>
>>> [...]
>>>>
>>>> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>>>> @@ -0,0 +1,45 @@
>>>
>>> [...]
>>>>
>>>> +&extal_clk {
>>>> +    clock-frequency = <16666666>;
>>>> +};
>>>> +
>>>> +&extalr_clk {
>>>> +    clock-frequency = <32768>;
>>>> +};
>>>> +
>>>
>>>      Forgot to specify SCIF_CLK -- it's populated.
>>
>>     Unfortunately, the kernel hangs after ttySC0 is registered if I specify
>> this frequency...
> 
> Is the crystal populated?

    It should be, with 14.7456MHz chrystal. But it's connected to SCIF_CLK_B 
pin -- perhaps that's the problem...

> When doing initial bringup of the remote Eagle I have access to, the SCIF
> registers didn't indicate SCIF_CLK was being used from U-Boot, while it
> is used on R-Car Gen2 boards that have it populated.

    Perhaps PFC is just not configured properly?

> 
> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
