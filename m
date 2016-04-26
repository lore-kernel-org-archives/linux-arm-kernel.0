From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 26 Apr 2016 13:22:17 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7
In-Reply-To: <5045792.GEWy4n0LSP@wuerfel>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
 <7781705.p6jrBl2RnJ@wuerfel>
 <CAMuHMdWmGKa16BOoF=MJab5V_Ceb1yAbAf2yjFV7sSHxG6=GOQ@mail.gmail.com>
 <5045792.GEWy4n0LSP@wuerfel>
Message-ID: <CAMuHMdU+1zcdjVv0OpdXQq2S107BgqR86UnN==ohaUhmMRKR5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Apr 26, 2016 at 12:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 26 April 2016 10:32:39 Geert Uytterhoeven wrote:
>> On Tue, Apr 26, 2016 at 10:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 26 April 2016 09:30:45 Geert Uytterhoeven wrote:
>> >> Commit 93fafa81cad3da9c ("Merge branches 'next/dt' and 'next/dt64' into
>> >> for-next") accidentally re-added the line
>> >>
>> >>         clock-output-names = "can_clk";
>> >>
>> >> to arch/arm/boot/dts/r8a7791.dtsi, which was removed in commit
>> >> f617604fe5d74b9c ("ARM: dts: r8a7791: Remove unnecessary
>> >> clock-output-names properties") before.  It seems the same wrong
>> >> conflict resolution was made before in commit ef3b08c6c0d85753 ("Merge
>> >> branch 'fixes' into for-next").
>> >>
>> >> While this won't cause failures, can you please remove the offending
>> >> line?
>> >
>> > I've merged renesas-fixes-for-v4.6 into next/dt now to resolve
>> > the conflict there, otherwise Linus would have to do the same resolution
>> > during the merge window.
>> >
>> > Thanks for letting us know. If you want to verify my new resolution,
>> > please look at next/dt, which is the more important branch.
>>
>> Thanks, but unfortunately your new merge resolution is incorrect, as it revived
>> the line
>>
>>         status = "disabled";
>>
>> for the pcie_bus node.
>
> I've done the merge once more, noticed my mistake (vimdiff syntax
> coloring was slightly misleading) and fixed it.

Thanks, that looks correct now!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
