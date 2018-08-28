From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Aug 2018 14:08:55 +0200
Subject: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
In-Reply-To: <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Geetha sowjanya <gakula@marvell.com>
>
> HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> create a IOMMU mapping for the physcial address configured by
> firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

I think this needs some more explanation. What is the difference between
the MSI-X support in this driver and every other one? Are you working
around a hardware bug, or is there something odd in the implementation
of your irqchip driver? Do you use a GIC to handle the MSI interrupts
or something else?

       Arnd
