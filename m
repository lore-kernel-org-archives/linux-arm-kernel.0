From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 08 May 2011 14:48:15 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
Message-ID: <4DC6910F.2020008@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2011 11:59 PM, Rafa? Mi?ecki wrote:
.....
> --- /dev/null
> +++ b/drivers/bcma/bcma_private.h
.....
> +
> +#define BCMA_ADDR_BASE		0x18000000
> +#define BCMA_WRAP_BASE		0x18100000
> +
......
> --- /dev/null
> +++ b/drivers/bcma/scan.h
> @@ -0,0 +1,56 @@
> +#ifndef BCMA_SCAN_H_
> +#define BCMA_SCAN_H_
> +
> +#define BCMA_ADDR_BASE		0x18000000
> +#define BCMA_WRAP_BASE		0x18100000
> +
.....

While graping through the code I found this. BCMA_ADDR_BASE and
BCMA_WRAP_BASE are defined twice.

Why are some constants defined in purpose specific headers in
drivers/bcma/*.h like drivers/bcma/scan.h and some in
drivers/bcma/bcma_private.h and other in include/linux/bcma/bcma_regs.h ?

Hauke
