From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Jun 2010 10:04:52 +0100
Subject: Preload engine in ARMv7 (cortex A8)
In-Reply-To: <AANLkTilGu3OC_tth-Wurgu1jcm5zKKntINGc-A8CwkxI@mail.gmail.com>
References: <AANLkTilGu3OC_tth-Wurgu1jcm5zKKntINGc-A8CwkxI@mail.gmail.com>
Message-ID: <1275901492.7258.6.camel@toshiba-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-01 at 18:27 +0100, Vinayak Pane wrote:
> I am planning to utilize the PreLoad Engine for L2 cache. In past, I
> have played with cache locking with line by line in ARM9. There I
> could recall that tags and indexes are generated on basis of physical
> address of the data. Now in case of PLE we have the start address and
> number of lines to fill with. Does the PLE operation will leave some
> indexes empty ? Or does the PLE populate all the lines in that way
> with the source data address ? Do I need to start PLE for the block of
> size equal to that of way-size ? To ensure no lines remain empty  and
> to ensure no line gets overwriten by other line.

I couldn't fully understand your question. It looks more like
hardware-related (you could try support at arm.com).

Anyway, in general you should not make any assumptions about which lines
are present or not in the cache. With speculative loads on newer cores,
you can get other lines in the cache than what you were expecting and
they may evict some the you explicitly tried to preload.

Catalin
