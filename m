From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Jun 2014 13:39:17 +0200
Subject: [PATCH v2 1/7] DMA: shdma: Add r8a7791 support
In-Reply-To: <2461508.0gZiIUPGHB@avalon>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-2-git-send-email-geert+renesas@glider.be>
 <2461508.0gZiIUPGHB@avalon>
Message-ID: <CAMuHMdXUt912Gkavn8ibw2yej7WGeULZTqG1wmmgLz1PDReJWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 1:29 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 02 June 2014 15:42:05 Geert Uytterhoeven wrote:
>
> Missing commit message ?

I didn't have anything more to say than the one-liner ;-)

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - No changes
>>
>>  Documentation/devicetree/bindings/dma/shdma.txt | 5 +++--
>>  drivers/dma/sh/shdmac.c                         | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/shdma.txt
>> b/Documentation/devicetree/bindings/dma/shdma.txt index
>> 86d5c509594b..d26b7065ae94 100644
>> --- a/Documentation/devicetree/bindings/dma/shdma.txt
>> +++ b/Documentation/devicetree/bindings/dma/shdma.txt
>> @@ -24,8 +24,9 @@ Optional properties (currently unused):
>>  Required properties:
>>  - compatible:        should be of the form "renesas,shdma-<soc>", where <soc>
>> should be replaced with the desired SoC model, e.g.
>> -             "renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
>> -             "renesas,shdma-r8a7790" for the DMAC on the R8A7790.
>> +             "renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC,
>> +             "renesas,shdma-r8a7790" for the DMAC on the R8A7790,
>> +             "renesas,shdma-r8a7791" for the DMAC on the R8A7791.
>
> I would just remove the commas and full stop to avoid modifying unrelated
> lines in future patches.
>
> The R8A7791 has several DMACs (LBSC, SYS, RT, Audio, 2D, USBHS). It would thus
> make sense to explicitly state which DMACs the bindings cover.

Good point. That also applies to the r8a7790.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
