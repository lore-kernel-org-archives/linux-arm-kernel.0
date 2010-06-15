From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Jun 2010 19:25:08 +0900
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <002001cb0c75$0a54fd00$1efef700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> This creates a DMAengine driver for the ARM PL080/PL081 PrimeCells
> based on the implementation earlier submitted by Peter Pearse.
> This is working like a charm for memcpy on the PB11MPCore, but
> slave DMA to devices is still not working.
> 
> This DMA controller is used in mostly unmodified form in the ARM
> RealView and Versatile platforms, in the ST-Ericsson Nomadik, and
> in the ST SPEAr platform.
> 
> It has been converted to use the header from the Samsung PL080
> derivate instead of its own defintions, and can potentially support
> several controllers in the same system.
> 
> Cc: Peter Pearse <peter.pearse@arm.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Looks good, but please give me some time to test on the board(SMDK6410).
If any problem, let you know. Of course no problem, will ack.

> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/include/asm/hardware/pl080.h |    2 +
>  drivers/dma/Kconfig                   |    9 +
>  drivers/dma/Makefile                  |    1 +
>  drivers/dma/amba-pl08x.c              | 1925
> +++++++++++++++++++++++++++++++++
>  include/linux/amba/pl08x.h            |  173 +++
>  5 files changed, 2110 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/amba-pl08x.c
>  create mode 100644 include/linux/amba/pl08x.h
> 
(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
