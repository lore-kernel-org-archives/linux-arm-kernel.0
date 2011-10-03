From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Oct 2011 09:50:29 +0100
Subject: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe
	function
In-Reply-To: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
References: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
	<cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
Message-ID: <20111003085029.GA11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 11:46:16AM +0200, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a652f8f..453cdb5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1789,7 +1789,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver atmel_serial_driver = {
> -	.probe		= atmel_serial_probe,
> +	.probe		= __devexit_p(atmel_serial_probe),

That doesn't match the patch description (and is probably wrong.)
