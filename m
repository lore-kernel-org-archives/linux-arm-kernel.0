From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 1 Feb 2015 10:11:59 +0100
Subject: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
In-Reply-To: <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
Message-ID: <CAMuHMdXcV8nxCvhMDZ3WRrWKXxxjR6d8Uf8gp5w9NUTkyTNTjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 1, 2015 at 4:39 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 4 Jan 2015, Geert Uytterhoeven wrote:
>
>> On Sun, Jan 4, 2015 at 8:21 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> > On Thu, 1 Jan 2015, Rickard Strandqvist wrote:
>> > > Removes some functions that are not used anywhere:
>> > > mac_pram_write() mac_pram_read()
>> >
>> > ... I'd rather not remove all of this code. Better to finish the
>> > implementation.
>>
>> Indeed.
>>
>> > Would it be acceptable to utilize drivers/char/generic_nvram.c and
>> > CONFIG_GENERIC_NVRAM? This is the PowerMac PRAM driver but looks
>> > generic enough that it may not need any modification for 68k Macs.
>>
>> Yes, that would be great.
>>
>
> Unfortunately, it seems to be unworkable.

An alternative could be to just provide an nvram attribute file in sysfs,
like many RTC drivers do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
