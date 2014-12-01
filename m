From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Dec 2014 09:05:37 +0100
Subject: [PATCH] ARM: shmobile: dts: koelsch: Fix flash partition label
 and size
In-Reply-To: <20141201003054.GA23212@verge.net.au>
References: <1416960805-15185-1-git-send-email-horms+renesas@verge.net.au>
 <5475CCA5.2020300@cogentembedded.com>
 <20141128002718.GF30850@verge.net.au>
 <CAMuHMdUUgCGq0igyJLJcRJitcmUR543O9tx399e+4jZfS4zQUg@mail.gmail.com>
 <20141201003054.GA23212@verge.net.au>
Message-ID: <CAMuHMdWnMBH1HD3TXxxc7nwcDCUYVSqZnrXThvw3Z5c42hOzPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 1, 2014 at 1:30 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Nov 28, 2014 at 09:34:05AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Nov 28, 2014 at 1:27 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Nov 26, 2014 at 03:50:45PM +0300, Sergei Shtylyov wrote:
>> >> On 11/26/2014 3:13 AM, Simon Horman wrote:
>> >> >"loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
>> >> >"user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
>> >> >"flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]
>> >>
>> >> >["user"'s assumed breakdown]
>> >> >U-boot+ bootargs(0x0008_0000-0x0010_0000) 512KB
>>
>> KiB
>>
>> You may want to split this explicitly in 256 KiB for U-boot, and 256 KiB for the
>> U-boot bootargs, to help people needing low-level recovery.
>
> Are you suggesting 4 partitions or just an adjustment of the assumption
> documented in the changelog?

Just the documentation.

I thought about having more partitions, though. But the two 256 KiB
blocks are just
two erase blocks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
