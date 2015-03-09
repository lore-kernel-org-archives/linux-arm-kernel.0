From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 15:42:14 +0100
Subject: [PATCH] ARM: l2c: enforce use of cache-level property
In-Reply-To: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
References: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CACRpkdaFvQ9mqnNRrj0j1YAeLQ3xUeUokQv-81AL6gxDeU+iWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 7:55 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:

> Make sure that we can read the "cache-level" property from the L2 cache
> controller node, and ensure its value is 2.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

(...)
> +       if (of_property_read_u32(np, "cache-level", &cache_level))
> +               pr_err("L2C: device tree omits to specify cache-level\n");
> +

Is that really an error? Does ePAPR specify that this must always be
present or what?

> +       if (cache_level != 2)
> +               pr_err("L2C: device tree specifies invalid cache level\n");

This is an error however.

Yours,
Linus Walleij
