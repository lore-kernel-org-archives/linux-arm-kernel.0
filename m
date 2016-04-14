From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 10:19:04 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.7
In-Reply-To: <20160413202328.GS19945@localhost>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
 <20160413194354.GQ19945@localhost>
 <CAMuHMdUbNcbLdQYG037MiDRAe1dr7ohRK625vb16oM8W19WEFw@mail.gmail.com>
 <20160413202328.GS19945@localhost>
Message-ID: <CAMuHMdXniFngia63Um6LN_5MKrFtJGQPeFFe7=e7Dj6A_X6PTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,Simon,

On Wed, Apr 13, 2016 at 10:23 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Apr 13, 2016 at 09:57:39PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Apr 13, 2016 at 9:43 PM, Olof Johansson <olof@lixom.net> wrote:
>> > On Mon, Apr 04, 2016 at 10:22:56AM +0900, Simon Horman wrote:
>> >> Geert Uytterhoeven (2):
>> >>       ARM: shmobile: timer: Fix preset_lpj leading to too short delays
>> >>       ARM: shmobile: timer: Drop support for Cortex A8
>> >
>> > I don't understand your naming. THis isn't driver code, this is SoC code.
>> >
>> > Anyway, I replied to the drop-A8 patch, the resulting function doesn't make
>> > much sense once that code path is removed (div is always 1). Seems like this
>> > should be cleaned up in other ways instead.
>> >
>> > So, not merging this branch for now since I think it should be revisited.
>>
>> The reason these are small separate patches is because especially the
>> first one may be backported to stable, as it's a real bug fix.
>
> Ok, so then the second shouldn't just remove cortex-a8, but rework the function
> (yet again).

Sure, reworking it...

Simon: I'm a bit surprised to see that "ARM: shmobile: timer: Fix preset_lpj
leading to too short delays" got postponed to v4.7, while commit 406663ed61c8
("ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE") is
already in v4.6-rc1.  The latter makes bad behavior due to too short delays
more likely to happen.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
