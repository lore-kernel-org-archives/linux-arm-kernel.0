From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Feb 2015 11:12:36 +0100
Subject: [PATCH v3] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <1624861.F2XBvOBm9V@wuerfel>
References: <1421684018-11894-1-git-send-email-geert+renesas@glider.be>
 <1467925.IxO001Hv1t@avalon>
 <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
 <1624861.F2XBvOBm9V@wuerfel>
Message-ID: <CAMuHMdU2B2wsR+UOnBAt-D1E1UkSDN9yxtiYjSWLRON-coq1QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jan 21, 2015 at 2:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 January 2015 14:09:56 Geert Uytterhoeven wrote:
>> On Wed, Jan 21, 2015 at 2:02 PM, Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com> wrote:
>> > To avoid bloating the kernel needlessly, couldn't at least some of the drivers
>> > needed for the shmobile boards be compiled as modules ? Audio, USB, SATA,
>> > touchscreen are possible candidates, depending on what we need to boot the
>> > boards to userspace.
>>
>> That's a possibility.
>>
>> Note that currently there are almost no modules in multi_v7_defconfig:
>> CONFIG_INET6_AH=m
>> CONFIG_INET6_ESP=m
>> CONFIG_INET6_IPCOMP=m
>> CONFIG_IPV6_MIP6=m
>> CONFIG_IPV6_TUNNEL=m
>> CONFIG_CFG80211=m
>> CONFIG_MAC80211=m
>> CONFIG_BRCMFMAC=m
>> CONFIG_RT2X00=m
>> CONFIG_RT2800USB=m
>>
>> Arnd, Olof: What do you prefer?
>
> I think it would be nice to move to having more loadable modules. We
> haven't really asked people to do that in the past, but the size is
> starting to become a problem and we may end up having to change a lot
> of the '=y' to '=m' in the future.

Do you want me to respin this patch with some options as modules?

One disadvantage of that is that it lets us discover less runtime-conflicts
between platforms using multi_v7_defconfig (does anyone boot arm
allyesconfig on his farm?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
