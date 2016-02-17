From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 17 Feb 2016 13:45:37 +0100
Subject: [PATCH/RFC v2 04/11] soc: renesas: rcar: Add DT support for SYSC
 PM domains
In-Reply-To: <3535519.g4KL1PCIZy@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <1455571020-18968-5-git-send-email-geert+renesas@glider.be>
 <3535519.g4KL1PCIZy@avalon>
Message-ID: <CAMuHMdVOMgHu2rV98m4GQ3TFJq74efh2jihFzuWBV3qQq39AmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, Feb 15, 2016 at 11:51 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 15 February 2016 22:16:53 Geert Uytterhoeven wrote:
>> Populate the SYSC PM domains from DT.
>>
>> Special cases, like PM domains containing CPU cores or SCUs, are
>> handled by scanning the DT topology.
>>
>> The SYSCIER register value is derived from the PM domains found in DT,
>> which will allow to get rid of the hardcoded values in pm-rcar-gen2.c.
>> However, this means we have to scan for PM domains even if CONFIG_PM=n.
>>
>> FIXME:
>>   - This needs better integration with the PM code in pm-rcar-gen2, the
>>     SMP code in smp-r8a7790, and Magnus' DT APMU series.
>
> Have you given this some thoughts already ? Unfortunately smp_prepare_cpus()
> is called before any initcall :-/ How do the other platforms handle this ?

I'm afraid no other platform already handles this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
