From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Dec 2013 20:40:30 +0100
Subject: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <52A62753.8060202@cogentembedded.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
 <201312082352.45265.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>
 <52A62753.8060202@cogentembedded.com>
Message-ID: <CAMuHMdXDHMRy2LTEa50omMs0dV9Vdf2woBsNAHzhkceXDfqyOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 9:25 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c
>>
>>
>>> +/* Ether */
>>> +static const struct sh_eth_plat_data ether_pdata __initconst = {
>>> +       .phy                    = 0x1,
>>> +       .edmac_endian           = EDMAC_LITTLE_ENDIAN,
>>> +       .phy_interface          = PHY_INTERFACE_MODE_RMII,
>>> +       .ether_link_active_low  = 1,
>>> +};
>
>> With the above, NFS root is terrible slow,
>
>    Do you get NFS timeout(s) on booting? I do. It's a known issue.

I only saw "NFS server not responding" once.

>    You can try my simplistic 'sh_eth' driver patch:
>
> http://marc.info/?l=linux-sh&m=137911743723032

Thanks, that also fixes the problem!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
