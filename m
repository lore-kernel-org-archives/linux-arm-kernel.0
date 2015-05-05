From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 May 2015 16:55:02 +0200
Subject: [PATCH v3 1/6] ARM: l2c: Add DT support for Shared Override
In-Reply-To: <20150505142211.GH22384@e104818-lin.cambridge.arm.com>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
 <1430753072-17145-2-git-send-email-geert+renesas@glider.be>
 <20150505112145.GG22384@e104818-lin.cambridge.arm.com>
 <CAMuHMdWE3HjGk73gCN3P-bBVEGrMbgfJ=FqvcTtGecs15R=A_g@mail.gmail.com>
 <20150505142211.GH22384@e104818-lin.cambridge.arm.com>
Message-ID: <CAMuHMdXpStgQpq6A7GDc2iXNgmBNWjP82E5TykzTUS=6hrWVRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, May 5, 2015 at 4:22 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, May 05, 2015 at 01:42:21PM +0200, Geert Uytterhoeven wrote:
>> On Tue, May 5, 2015 at 1:21 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, May 04, 2015 at 05:24:27PM +0200, Geert Uytterhoeven wrote:
>> >> Hence add support for an "arm,shared-override" device tree property for
>> >> the l2c device node. By specifying this property, affected systems can
>> >> indicate that non-cacheable transactions must not be transformed.
>> >>
>> >> If specified, the actual behavior of the kernel depends on whether CMA
>> >> is available or not:
>> >>   - If CMA is available, nothing needs to be done, as there won't be a
>> >>     kernel linear mappings and cacheable aliases for the DMA buffers,
>> >
>> > I don't think this is true. See this thread:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/329492.html
>>
>> Doh, and I had hoped to please Russell...
>>
>> To bad, will drop this.
>
> You should only drop the "if (dev_get_cma_area(NULL))" check.

Of course.

> BTW, your patch mentions r2p0. My reading of the PL310 TRM shows this
> bit as default from r0p0.

Arnd told me he had read the documentation for r0p0 and couldn't find it.
The r3p2 manual lists the following changes between r1p0-r2p0:
  - new behavior linked to the Shared attribute.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
