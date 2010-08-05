From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 5 Aug 2010 14:58:12 +0530
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTikFULpLdqOF9q2vpxiQKb__zzDRGGoYR1qE=zwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 29, 2010 at 5:06 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This creates a DMAengine driver for the ARM PL080/PL081 PrimeCells
> based on the implementation earlier submitted by Peter Pearse.
> This is working like a charm for memcpy and slave DMA to the PL011
> PrimeCell on the PB11MPCore.
>
> This DMA controller is used in mostly unmodified form in the ARM
> RealView and Versatile platforms, in the ST-Ericsson Nomadik, and
> in the ST SPEAr platform.
>
> It has been converted to use the header from the Samsung PL080
> derivate instead of its own defintions. The Samsungs have a custom
> driver in their mach-* folders though, atleast we can share the
> register definitions.
>
> Cc: Peter Pearse <peter.pearse@arm.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes since last revision: this has now been successfully tested
> with PL011 UART on the PB11MPCore.
>
> It now uses the generic runtime slave control and not the PrimeCell
> extensions, and thus depends only on that patch set. With the previous
> patch to the header file this is cleanly separated from the ARM tree
> and any PrimeCell drivers and can go into the async_tx tree as it is
> without further dependencies.
> ---
> ?drivers/dma/Kconfig ? ? ? ?| ? ?8 +
> ?drivers/dma/Makefile ? ? ? | ? ?1 +
> ?drivers/dma/amba-pl08x.c ? | 2027 ++++++++++++++++++++++++++++++++++++++++++++
> ?include/linux/amba/pl08x.h | ?183 ++++
> ?4 files changed, 2219 insertions(+), 0 deletions(-)
> ?create mode 100644 drivers/dma/amba-pl08x.c
> ?create mode 100644 include/linux/amba/pl08x.h
>

Acked-by: Viresh Kumar <viresh.kumar@st.com>

regards,
viresh.
