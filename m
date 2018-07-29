From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:33:48 +0200
Subject: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
In-Reply-To: <20180718235710.18242-8-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-8-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdZ316o4rwCftOWsRMNd3B+4v0mWGbdMFvp1mm7yaFsccA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz!

Nice work overall! Some feedback:

On Thu, Jul 19, 2018 at 1:57 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> +#include <linux/gpio/driver.h>

Let's skip that.

> +       /*
> +        * For acceptable performance require the data GPIO
> +        * chip to support get/set_multiple() callbacks.
> +        */
> +       if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
> +               err = -EINVAL;
> +               dev_err(&pdev->dev,
> +                       "data GPIO chip does not support get/set_multiple()\n");
> +               goto out_mtd;
> +       }

Since we know which platform it is, we know that we applied the previous
get/set multiple patch, so we need not check this if the patches are
applied in sequence.

As long as all patches go in the same merge window, no problem.

I'm BTW ready to apply the get/set multiple patch already.

Yours,
Linus Walleij
