From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 22 Aug 2011 16:22:04 +0530
Subject: [PATCH] DMA: PL330: Merge PL330 drivers
In-Reply-To: <1313988751-29538-1-git-send-email-boojin.kim@samsung.com>
References: <1313988751-29538-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY1gBJDPgZFPjfTk4Q6Lcp0JRViprOGb2RS+Bw5+wpHn7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 10:22 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch merges 'arch/arm/common/pl330.c' with 'driver/dma/pl330.c'
>
> NOTE: this patch is made on following patches.
> - [PATCH v6] To use DMA generic APIs for Samsung DMA
> - [PATCH v4] amba: consolidate PrimeCell magic
This doesn't make sense in changelog. Such notes usually go below
the '---' line below last SOB

>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> ---
> ?arch/arm/common/Kconfig ? ? ? ? ? ? ? | ? ?3 -
> ?arch/arm/common/Makefile ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/common/pl330.c ? ? ? ? ? ? ? | 1931 -------------------------------
> ?arch/arm/include/asm/hardware/pl330.h | ?217 ----
> ?drivers/dma/Kconfig ? ? ? ? ? ? ? ? ? | ? ?1 -
> ?drivers/dma/pl330.c ? ? ? ? ? ? ? ? ? | 2036 +++++++++++++++++++++++++++++++++
> ?include/linux/amba/pl330.h ? ? ? ? ? ?| ? 11 +-
> ?7 files changed, 2046 insertions(+), 2154 deletions(-)
> ?delete mode 100644 arch/arm/common/pl330.c
> ?delete mode 100644 arch/arm/include/asm/hardware/pl330.h

....

> diff --git a/arch/arm/include/asm/hardware/pl330.h b/arch/arm/include/asm/hardware/pl330.h
> deleted file mode 100644
> index 575fa81..0000000
> --- a/arch/arm/include/asm/hardware/pl330.h
> +++ /dev/null
> @@ -1,217 +0,0 @@
> -/* linux/include/asm/hardware/pl330.h
> - *
> - * Copyright (C) 2010 Samsung Electronics Co. Ltd.
> - * ? ? Jaswinder Singh <jassi.brar@samsung.com>

While at it, please also modify the instances of author id to
      'Jassi Brar <jassisinghbrar@gmail.com>
I think we can accommodate the trivial change.
