From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 29 Sep 2010 16:59:32 +0200
Subject: [PATCH] amba-pl011: add missing ST specific registers
In-Reply-To: <1285764689-4772-1-git-send-email-linus.walleij@stericsson.com>
References: <1285764689-4772-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100929145932.GG30987@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:51 Wed 29 Sep     , Linus Walleij wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> The ST Micro derivates have several extra interesting registers
> that we may soon use for something interesting so may just as
> well define them in the header.
> 
> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  include/linux/amba/serial.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
> index e1b634b..6021588 100644
> --- a/include/linux/amba/serial.h
> +++ b/include/linux/amba/serial.h
> @@ -32,7 +32,9 @@
>  #define UART01x_RSR		0x04	/* Receive status register (Read). */
>  #define UART01x_ECR		0x04	/* Error clear register (Write). */
>  #define UART010_LCRH		0x08	/* Line control register, high byte. */
> +#define ST_UART011_DMAWM	0x08    /* DMA watermark configure register. */
this
>  #define UART010_LCRM		0x0C	/* Line control register, middle byte. */
> +#define ST_UART011_TIMEOUT	0x0C    /* Timeout period register. */
abd this are overwritng the default register how do plan to handle it?
it will be better to add them at the same time as you use them

btw you have whitespace in patch

Best Regards,
J.
