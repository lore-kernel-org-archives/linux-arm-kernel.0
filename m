From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 May 2017 16:08:29 +0200
Subject: [PATCH] arm64: Fix the DMA mmap and get_sgtable API with
 DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <20170504140306.GB25108@e104818-lin.cambridge.arm.com>
References: <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
 <7d0445e5-ddb3-7d0f-4749-c63b54beff43@arm.com>
 <20170504140306.GB25108@e104818-lin.cambridge.arm.com>
Message-ID: <CAMuHMdXGutH1w8_yV3oToCXoOt3phWE5-b_Sovd8aAP7jC8MPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, May 4, 2017 at 4:03 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Going through the past threads on this, I wonder whether the attribute
> is actually used anywhere (in which case we may be better off reverting
> the original patch). If improved IOMMU performance is required, there

AFAIK, the users are somewhere in the pipeline.

> are likely better ways to achieve this like using a different page size
> at the IOMMU level.

If I'm not mistaken, it's intended to be used when one device cannot use
the IOMMU for whatever reason.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
