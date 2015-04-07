From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Tue, 07 Apr 2015 18:51:56 +0200
Subject: [PATCH v6 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428424234-28572-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <55240B2C.3020102@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2015 um 18:30 schrieb Maxime Coquelin:
> This drivers adds support to the STM32 USART controller, which is a
> standard serial driver.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/tty/serial/Kconfig       |  17 +
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/stm32-usart.c | 735 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 756 insertions(+)
>  create mode 100644 drivers/tty/serial/stm32-usart.c
[...]
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> new file mode 100644
> index 0000000..4adc430
> --- /dev/null
> +++ b/drivers/tty/serial/stm32-usart.c
[...]
> +#define DRIVER_NAME "stm32-usart"
> +#define STM32_SERIAL_NAME "ttyS"

I'm surprised no one has complained about ttyS yet. Doesn't that need to
be unique, such as ttySTM (efm32 uses ttyefm), to avoid clashes between
serial drivers? ttyS was exclusive to the 8250 driver, I thought.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
