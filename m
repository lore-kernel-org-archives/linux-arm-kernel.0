From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 12 Oct 2009 00:10:43 +0200
Subject: [PATCH v1 2/2] OMAP3: add platform devices for ETM and ETB
In-Reply-To: <1255279286-8904-2-git-send-email-virtuoso@slind.org>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<1255279286-8904-2-git-send-email-virtuoso@slind.org>
Message-ID: <63386a3d0910111510q2e17fec7ofe3db29a4d1f7822@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/11 Alexander Shishkin <virtuoso@slind.org>:

> This enables debug components found in omap3xxx.
> (...)
> +static struct resource rx51_etb_resource = {
> + ? ? ? .start = ETB_BASE,
> + ? ? ? .end ? = ETB_BASE + SZ_4K,

.end = ETB_BASE + SZ_4K - 1

This will play with the resource paradigm and resource_size() will
work correctly in the driver after this.

> + ? ? ? .flags = IORESOURCE_MEM,
> +};
> +
>(...)
> +
> +static struct resource rx51_etm_resource = {
> + ? ? ? .start = ETM_BASE,
> + ? ? ? .end ? = ETM_BASE + SZ_4K,

Ditto.

> + ? ? ? .flags = IORESOURCE_MEM,
> +};

Linus Walleij
