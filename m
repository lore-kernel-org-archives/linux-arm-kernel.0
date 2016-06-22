From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 22 Jun 2016 10:01:40 +0530
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 3:32 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add Amlogic Meson SoCs Message-Handling-Unit as mailbox controller
> with 2 independent channels/links to communicate with a remote processor.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

.....

> +++ b/drivers/mailbox/meson_mhu.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (C) 2016 BayLibre SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Heavily based on meson_mhu.c from :
> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Jassi Brar <jaswinder.singh@linaro.org>

.........
> +
> +#define INTR_SET_OFS   0x0
> +#define INTR_STAT_OFS  0x4
> +#define INTR_CLR_OFS   0x8
> +
> +#define MHU_LP_OFFSET  0x10
> +#define MHU_HP_OFFSET  0x1c
> +
> +#define TX_REG_OFFSET  0x24
> +
It seems only some register offsets have changed from arm_mhu. So
maybe just adapt the arm_mhu driver to look for IP variant and assign
corresponding offsets to set,stat,clr registers.

Cheers.
