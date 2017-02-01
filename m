From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Feb 2017 16:34:27 +0100
Subject: [PATCH 2/2] arm64/dma-mapping: validate dma_masks against IORT
 defined limits
In-Reply-To: <f8eb99ca-bb5d-105e-19ac-73e7d4e75ec6@arm.com>
References: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
 <1485893763-20671-2-git-send-email-nwatters@codeaurora.org>
 <115903ce-6c1d-faa9-cbe4-e67a3d41f5c9@arm.com>
 <20170201143617.GB20423@red-moon>
 <f8eb99ca-bb5d-105e-19ac-73e7d4e75ec6@arm.com>
Message-ID: <CAK8P3a34oCsp8WAnf5EJVT5ioYVmR9aZx0nhEmmT0Sof7QRdaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 4:27 PM, Robin Murphy <robin.murphy@arm.com> wrote:

>
> Essentially, all that needs to be done is to ensure that the initial
> masks set by acpi_dma_configure() truly reflect the maximum hardware
> capability; everything else will then just fall out of that. The
> aforementioned thing on the DT side is that of_dma_configure() currently
> has a bug which prevents masks larger than 32 bits actually being
> assigned from "dma-ranges" - I need to split out a proper patch from the
> "git commit -am 'hacks'" that I have on this local branch :)

Do you mean you want to change the initial DMA mask to the maximum allowed
mask? I don't think we can do that, as that would break all devices that support
only 32-bit DMA but happen to sit on a bus that has 64-bit DMA support.

    Arnd
