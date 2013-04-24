From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Apr 2013 16:54:49 +0200
Subject: [PATCH 03/32 v2] dmaengine: ste_dma40: Use the BIT macro to
 replace ugly '(1 << x)'s
In-Reply-To: <20130418121637.GG27903@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-4-git-send-email-lee.jones@linaro.org>
 <20130418121637.GG27903@gmail.com>
Message-ID: <CACRpkdYCub2GN5okM4NW9E5snwVnGKvnGd02V2qLX=s6R04e9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 2:16 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The aim is to make the code that little more readable.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 3b83dee..ddf5ff1 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -49,9 +49,9 @@
>  #define MAX_LCLA_ALLOC_ATTEMPTS 256
>
>  /* Bit markings for allocation map */
> -#define D40_ALLOC_FREE         (1 << 31)
> -#define D40_ALLOC_PHY          (1 << 30)
> -#define D40_ALLOC_LOG_FREE     0
> +#define D40_ALLOC_FREE         BIT(31)
> +#define D40_ALLOC_PHY          BIT(30)
> +#define D40_ALLOC_LOG_FREE     BIT(0)

No. 0 != BIT(0)

Please fix this...

Yours,
Linus Walleij
