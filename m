From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Dec 2010 22:55:38 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20101221155935.GV28157@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> This also contains a few other tweaks on top of your original patch too.
> All the DMA conditionals get optimized out when we're not building with
> a DMA engine enabled platform.

Thanks.

> Note that in your original code, mmci_dma_data_error() is always followed
> by a call to mmci_dma_data_end(), and that resulted in dma_unmap_sg()
> being called twice for the same buffer.

Ulf Hansson notified me on this too, last week or so.
Sorry for not fixing in time.

> Also, dma_map_sg() returns the number of physical entries mapped, or zero
> on failure. ?Should we have a DMA mapping implementation which coalesces
> entries, the returned number will be less than data->nr_sg, and it is the
> number of coalesced entries which should be passed to the DMA engine driver.

Per F?rlin reported this one as well.
Sorry again.

> You have this bug in the PL022 driver too, so I suspect that your other
> drivers need fixing for this.

Fixing patches for PL022 now, thanks a lot Russell.

Yours,
Linus Walleij
