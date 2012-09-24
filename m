From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Sep 2012 18:29:22 +0000
Subject: [PATCH v2] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <1348509352-19278-1-git-send-email-shc_work@mail.ru>
References: <1348509352-19278-1-git-send-email-shc_work@mail.ru>
Message-ID: <201209241829.22773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 September 2012, Alexander Shiyan wrote:
> +
> +static const u32 clps711x_ports[] = {
> +       _PADR, _PBDR, _PCDR, _PDDR, _PEDR,
> +};
> +
> +static const u32 clps711x_pdirs[] = {
> +       _PADDR, _PBDDR, _PCDDR, _PDDDR, _PEDDR,
> +};
> +
> +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       return !!readb(clps711x_ports[chip->base / 8]) & (1 << offset);
> +}

In 3.7 and later, you won't be able to readb/writeb on an integer address,
all addresses have to be of "void __iomem *" or compatible type.

	Arnd
