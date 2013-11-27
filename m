From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Nov 2013 14:05:29 -0800
Subject: [PATCH v5 08/17] clk: at91: add PMC system clocks
In-Reply-To: <1384293935-4755-1-git-send-email-b.brezillon@overkiz.com>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
 <1384293935-4755-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131127220529.16819.42204@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2013-11-12 14:05:35)
> This patch adds new at91 system clock implementation using common clk
> framework.
> 
> Some peripherals need to enable a "system" clock in order to work properly.
> Each system clock is given an id based on the bit position in SCER/SCDR
> registers.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/clk/at91/Makefile     |    1 +
>  drivers/clk/at91/clk-system.c |  137 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/at91/pmc.c        |    5 ++
>  drivers/clk/at91/pmc.h        |    3 +
>  4 files changed, 146 insertions(+)
>  create mode 100644 drivers/clk/at91/clk-system.c
> 
> diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
> index e28fb2b..c2b7068 100644
> --- a/drivers/clk/at91/Makefile
> +++ b/drivers/clk/at91/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-y += pmc.o
>  obj-y += clk-main.o clk-pll.o clk-plldiv.o clk-master.o
> +obj-y += clk-system.o
> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
> new file mode 100644
> index 0000000..1c086f4
> --- /dev/null
> +++ b/drivers/clk/at91/clk-system.c
> @@ -0,0 +1,137 @@
> +/*
> + * drivers/clk/at91/clk-system.c

Nitpick: it's better to not put file paths in a comment block in case
the file name or path is changed.

Regards,
Mike
