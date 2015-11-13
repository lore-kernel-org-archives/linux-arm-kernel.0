From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Nov 2015 08:52:14 +0100
Subject: [PATCH v2 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <20151113005157.GF20462@verge.net.au>
References: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
 <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWi=uTAtNvhSA54JDms_pLW0zjKQ_VH8xU3eY6BGiwV5A@mail.gmail.com>
 <20151113005157.GF20462@verge.net.au>
Message-ID: <CAMuHMdV9pWAdP-dOTDnkxCDkb1azGjKNH8u-8yvNbaUTWSSCDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Nov 13, 2015 at 1:51 AM, Simon Horman <horms@verge.net.au> wrote:
>> > Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
>>
>> That's slow: I get 6.7 MB/s on koelsch (69.9 Mbps for Quad Read according
>> to my in-kernel QSPI debug code). Is this with SYS-DMAC enabled?
>
> Yes it does seem very small.
>
> I think that the problem is that /dev/mtd0 is very small, only 262kB.
> And I do not see any interrupts for dma-controllers when reading from hit.

Performance suffers badly from using small block sizes, so that explains it.

> /dev/mdt1 is much later, 4.2MB.
> dd reads that at ~7MB/s using 512kB blocks.

That's better.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
