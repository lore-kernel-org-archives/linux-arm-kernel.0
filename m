From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Jan 2018 11:22:35 +0100
Subject: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <878tdgtwzp.fsf@concordia.ellerman.id.au>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au>
Message-ID: <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christoph Hellwig <hch@lst.de> writes:
>
>> We want to use the dma_direct_ namespace for a generic implementation,
>> so rename powerpc to the second best choice: dma_nommu_.
>
> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
> than mapping dynamically.
>
> Though I don't have a good idea for a better name, maybe "1to1",
> "linear", "premapped" ?

"identity"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
