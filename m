From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Aug 2016 15:15:15 +0200
Subject: [PATCH v4 4/6] ARM: dts: r8a7794: add Audio-DMAC support
In-Reply-To: <CAMuHMdWofFF9PrBW4n0GTytP8Mm7_mwPU=O7mXRPWUDXBOfOTA@mail.gmail.com>
References: <3910788.ckTpUWEs6B@wasted.cogentembedded.com>
 <6419837.qqlciQTB8q@wasted.cogentembedded.com>
 <CAMuHMdWofFF9PrBW4n0GTytP8Mm7_mwPU=O7mXRPWUDXBOfOTA@mail.gmail.com>
Message-ID: <CAMuHMdVdb5EB7Pt3YYKXsRWAdCpKj6cg1dapZd-johzW7axpgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2016 at 3:14 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jul 27, 2016 at 11:02 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>> Describe Audio-DMAC in the R8A7794 device tree.
>>
>> This patch is loosely based on the commit 8994fff67761 ("ARM: shmobile:
>> r8a7791: Add Audio DMAC devices to DT").
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> Changes in version 4:
>> - refreshed the patch.
>>
>> Changes in version 3:
>> - refreshed the patch.
>>
>>  arch/arm/boot/dts/r8a7794.dtsi |   28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
>> @@ -296,6 +296,34 @@
>>                 dma-channels = <15>;
>>         };
>>
>> +       audma0: dma-controller at ec700000 {

>> +               dma-channels = <13>;
>> +       };
>
> According to R-Car-Gen2-common-v2.00.pdf (Audio-DMAC and INTC-SYS
> chapters), V2H has only 2 audio DMA channels, not 13.

Scrap it, this is a patch for E2, not V2H.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
