From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 09 Aug 2011 15:41:35 +0400
Subject: [PATCH] atmel_serial: fix atmel_default_console_device
In-Reply-To: <loom.20110808T170457-559@post.gmane.org>
References: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
	<1308666679-12111-1-git-send-email-plagnioj@jcrosoft.com>
	<loom.20110808T170457-559@post.gmane.org>
Message-ID: <4E411CEF.10004@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-08-2011 19:10, Nikolaus Voss wrote:

> reflect new static uart platform ids introduced by patch
> http://article.gmane.org/gmane.linux.kernel/1126105

> Signed-off-by: Nikolaus Voss<n.voss@weinmannn.de>

> ---
>   drivers/tty/serial/atmel_serial.c |    7 ++++---
>   1 files changed, 4 insertions(+), 3 deletions(-)

> diff --git a/drivers/tty/serial/atmel_serial.c \
> 	b/drivers/tty/serial/atmel_serial.c
> index af9b781..29c7857 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1609,9 +1609,10 @@ static struct console atmel_console = {
>   static int __init atmel_console_init(void)
>   {
>   	if (atmel_default_console_device) {
> -		add_preferred_console(ATMEL_DEVICENAME,
> -				      atmel_default_console_device->id, NULL);
> -		atmel_init_port(&atmel_ports[atmel_default_console_device->id],
> +		struct atmel_uart_data *pdata =
> +			atmel_default_console_device->dev.platform_data;

    Would be good to have empty line after the declaration...

> +		add_preferred_console(ATMEL_DEVICENAME, pdata->num, NULL);
> +		atmel_init_port(&atmel_ports[pdata->num],
>   				atmel_default_console_device);
>   		register_console(&atmel_console);
>   	}

WBR, Sergei
