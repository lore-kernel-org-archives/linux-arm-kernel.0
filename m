From: eric@anholt.net (Eric Anholt)
Date: Fri, 03 Nov 2017 13:18:28 -0700
Subject: [PATCH 12/12] hwrng: bcm63xx-rng: Remove since bcm2835-rng takes
 over
In-Reply-To: <20171102010408.27736-13-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <20171102010408.27736-13-f.fainelli@gmail.com>
Message-ID: <877ev7ru97.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> bcm2835-rng is now capable of supporting the BCM63xx hardware, so remove
> the driver which duplicates the same functionality.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/char/hw_random/Kconfig       |  13 ---
>  drivers/char/hw_random/Makefile      |   1 -
>  drivers/char/hw_random/bcm63xx-rng.c | 154 -----------------------------------
>  3 files changed, 168 deletions(-)
>  delete mode 100644 drivers/char/hw_random/bcm63xx-rng.c
>

> diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
> deleted file mode 100644
> index 5132c9cde50d..000000000000
> --- a/drivers/char/hw_random/bcm63xx-rng.c
> +++ /dev/null

> -static int bcm63xx_rng_data_present(struct hwrng *rng, int wait)
> -{
> -	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
> -
> -	return __raw_readl(priv->regs + RNG_STAT) & RNG_AVAIL_MASK;
> -}

It looks like this method isn't in the 2835 implementation.  Should it
get ported over?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/869b7075/attachment.sig>
