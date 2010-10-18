From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 18 Oct 2010 19:13:07 +0100
Subject: [PATCH 0/7] arm/versatile PCI support, second try
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <AANLkTi=ZAPMAS-vw2RVAz28jdDtnTTobkxz4QTDTUeTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2010 17:10, Arnd Bergmann <arnd@arndb.de> wrote:
> With lots of help and testing from Peter Maydell, I've completed
> a second version of the PCI support for the versatile platform,
> which works much better now on real hardware, although it does
> not improve existing qemu setups.
>
> Please review and test.

Confirmed that this patchset gives working PCI (tested with a
sata_via PCI card and disk) on PB926, and working PCI except
for busmaster DMA on PB1176 (same test setup, booting with
libata.dma=0). (Without the patchset PCI doesn't work at all
because the sata_via driver crashes the first time it tries an
I/O access, so even without the 1176 busmastering it's a huge
improvement over the existing situation.)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM
