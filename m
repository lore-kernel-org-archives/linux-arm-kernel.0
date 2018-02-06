From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 6 Feb 2018 19:41:07 +0300
Subject: [PATCH 07/11] arm64: dts: renesas: r8a77980: add [H]SCIF support
In-Reply-To: <CAMuHMdWXc=1s5rMU5Tc_=tH4jrH+5P6z52J3ihiyYfseTpQ-kw@mail.gmail.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <169ed4ac-1b8b-cf8c-45c4-957ebbdf3f5e@cogentembedded.com>
 <CAMuHMdWXc=1s5rMU5Tc_=tH4jrH+5P6z52J3ihiyYfseTpQ-kw@mail.gmail.com>
Message-ID: <f440c853-d955-bba9-dc58-d7670f521a73@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2018 02:58 PM, Geert Uytterhoeven wrote:

>> Describe [H]SCIF ports in the R8A77980 device tree.
>>
>> Based on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your patch!
> 
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> 
>> @@ -85,6 +92,150 @@
>>                         #power-domain-cells = <1>;
>>                 };
>>
>> +               hscif0: serial at e6540000 {
>> +                       compatible = "renesas,hscif-r8a77980",
>> +                                    "renesas,rcar-gen3-hscif",
>> +                                    "renesas,hscif";
>> +                       reg = <0 0xe6540000 0 0x60>;
>> +                       interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpg CPG_MOD 520>,
>> +                                <&cpg CPG_CORE 16>,
> 
> Shouldn't this be 19 (S3D1) instead of 16 (S2D1)?

   Seems like that... at least after out chat. :-)

> With that fixed (for all (H)SCIF ports);

   The manual tells me SCKi for the SCIF ports should be the same S3D1.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 

MBR, Sergei
