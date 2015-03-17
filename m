From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Mar 2015 12:49:11 +0100
Subject: [PATCH v2 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <1426064430-5826-2-git-send-email-carlo@caione.org>
References: <1426064430-5826-1-git-send-email-carlo@caione.org>
 <1426064430-5826-2-git-send-email-carlo@caione.org>
Message-ID: <CACRpkday9fO9mSr03qSy0jT1bG+Vu9qE6FUd8eZqxdnicuBTYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 10:00 AM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> This patch adds support for the AmLogic Meson8b SoC.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

(...)

> diff --git a/include/dt-bindings/gpio/meson8b-gpio.h b/include/dt-bindings/gpio/meson8b-gpio.h
> new file mode 100644
> index 0000000..0d6b7f1
> --- /dev/null
> +++ b/include/dt-bindings/gpio/meson8b-gpio.h

Why is this not in <dt-bindings/pinctrl/*> ?

> @@ -0,0 +1,31 @@
> +/*
> + * GPIO definitions for Amlogic Meson8b SoCs
> + *
> + * Copyright (C) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _DT_BINDINGS_MESON8B_GPIO_H
> +#define _DT_BINDINGS_MESON8B_GPIO_H
> +
> +#include <dt-bindings/gpio/meson8-gpio.h>

Why is this file including itself?

> +
> +#define DIF_0_P                0
> +#define DIF_0_N                1
> +#define DIF_1_P                2
> +#define DIF_1_N                3
> +#define DIF_2_P                4
> +#define DIF_2_N                5
> +#define DIF_3_P                6
> +#define DIF_3_N                7
> +#define DIF_4_P                8
> +#define DIF_4_N                9

Moreover, *what* is this DIF stuff and why is there no binding
document for it?

Yours,
Linus Walleij
