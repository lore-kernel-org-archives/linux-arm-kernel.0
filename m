From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 21:11:33 +0200
Subject: [PATCH 2/3] ARM: PCI: versatile: Fix PCI I/O
In-Reply-To: <1377190070-7305-3-git-send-email-peter.maydell@linaro.org>
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
 <1377190070-7305-3-git-send-email-peter.maydell@linaro.org>
Message-ID: <CACRpkdbV5EbdS9cJNyOeL+tRwLqcyPE4_nLKH3vYarExLjn2Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 6:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:

> The versatile PCI controller code was confused between the
> PCI I/O window (at 0x43000000) and the first PCI memory
> window (at 0x44000000). Pass the correct base address to
> pci_remap_io() so that PCI I/O accesses work.
>
> Since the first PCI memory window isn't used at all (it's
> an odd size), rename the associated variables and labels
> so that it's clear that it isn't related to the I/O window.
>
> This has been tested and confirmed to fix PCI I/O accesses
> both on physical PB926+PCI backplane hardware and on QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
