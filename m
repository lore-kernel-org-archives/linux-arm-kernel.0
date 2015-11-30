From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:47:03 +0100
Subject: [PATCH v2] pinctrl: at91-pio4: use %pr format string for resource
In-Reply-To: <5199877.GVYeflqET9@wuerfel>
References: <5199877.GVYeflqET9@wuerfel>
Message-ID: <CACRpkdZ4F8Loyoh6niCvkM=S8KcekTs8EvXRmB-0WxcRFw_8+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 4:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> resource_size_t may be defined as 32 or 64 bit depending on configuration,
> so it cannot be printed using the normal format strings, as gcc correctly
> warns:
>
> pinctrl-at91-pio4.c: In function 'atmel_pinctrl_probe':
> pinctrl-at91-pio4.c:1003:41: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
>    dev_dbg(dev, "bank %i: hwirq=%u\n", i, res->start);
>
> This changes the format string to use the special "%pr" format
> string that prints a resource, and changes the arguments so we
> the resource structure directly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: don't break ordering of arguments, that part was correct already, unlike
> what I said in v1.

Patch applied with Ludovic's review tag.

Yours,
Linus Walleij
