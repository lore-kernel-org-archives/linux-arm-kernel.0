From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 10 Aug 2015 12:28:17 +0530
Subject: [PATCH v2 2/6] mailbox: dt-bindings: Add shared [driver <=>
 device tree] defines
In-Reply-To: <1437990272-23111-3-git-send-email-lee.jones@linaro.org>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CABb+yY2asjH-c+VJXvG+RK0=2p=P4Y21pznNP0riaKMWLxYZog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> This header is currently only used for defines pertaining to data
> direction i.e. Rx, Tx or Loopback.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/dt-bindings/mailbox/mailbox.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/mailbox/mailbox.h
>
> diff --git a/include/dt-bindings/mailbox/mailbox.h b/include/dt-bindings/mailbox/mailbox.h
> new file mode 100644
> index 0000000..82e929a
> --- /dev/null
> +++ b/include/dt-bindings/mailbox/mailbox.h
> @@ -0,0 +1,14 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MAILBOX_CONTROLLER_DT_BINDINGS_H
> +#define __MAILBOX_CONTROLLER_DT_BINDINGS_H
> +
> +#define MBOX_TX                0x1
> +#define MBOX_RX                0x2
> +#define MBOX_LOOPBACK  (MBOX_RX | MBOX_TX)
> +
Not sure I understand 'loopback'.  Does it mean h/w has some
'loopback' mode for testing purposes? Or it simply means the
controller can send as well as receive messages?

Thanks.
