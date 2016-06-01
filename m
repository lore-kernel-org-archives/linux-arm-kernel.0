From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 2 Jun 2016 00:00:02 +0300
Subject: [PATCH 04/13] ARM: shmobile: r8a7792: basic SoC support
In-Reply-To: <CAMuHMdXtqwby6_E-izx=h=ryQfH2LsXvNyP+14rnaF-TksmEbg@mail.gmail.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2352834.cNFKgiQiVO@wasted.cogentembedded.com>
 <CAMuHMdXtqwby6_E-izx=h=ryQfH2LsXvNyP+14rnaF-TksmEbg@mail.gmail.com>
Message-ID: <f7b4e1f5-dcbc-06b5-ac44-af6bef9b2658@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 10:47 AM, Geert Uytterhoeven wrote:

>> --- renesas.orig/arch/arm/mach-shmobile/Kconfig
>> +++ renesas/arch/arm/mach-shmobile/Kconfig
>> @@ -86,6 +86,11 @@ config ARCH_R8A7791
>>         select ARCH_RCAR_GEN2
>>         select I2C
>>
>> +config ARCH_R8A7792
>> +       bool "R-Car V2H (R8A77920)"
>> +       select ARCH_RCAR_GEN2
>> +       select I2C
>
> I2c is selected for the other SoCs because of regulator-quirk-rcar-gen2.
> I do not have schematics for Blanche, so I don't know if it has DA9063 and
> DA9210 regulators sharing the same interrupt.

    No, it only has DA9063.

> If yes, you should make sure regulator-quirk-rcar-gen2 is updated for Blanche,
> and built.
> If no, you should drop the select.

    Thanks for noticing!

> If the above is clarified:

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

    Thank you, adding...

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
