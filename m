From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 27 Jan 2015 07:44:19 -0500
Subject: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
In-Reply-To: <1422334209-23125-2-git-send-email-robh@kernel.org>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
Message-ID: <54C78823.7050504@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/26/2015 11:50 PM, Rob Herring wrote:
> Add mrvl,pxa-uart and mrvl,mmp-uart compatible strings for the of_serial
> driver. These are 8250 variants which have a port type of PORT_XSCALE.
> 
> There is also the serial driver pxa.c with these compatible strings
> already. However, it can be replaced with the common 8250 driver. It has
> some issues like it cannot coexist with the 8250 driver due to tty name
> collision. That also means adding these compatible strings here should
> not case a problem.

So what determines which driver is controlling the port if both
drivers are built-in?

Regards,
Peter Hurley

> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> ---
>  drivers/tty/serial/of_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 3194b42..fbb719c 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -335,6 +335,10 @@ static struct of_device_id of_platform_serial_table[] = {
>  		.data = (void *)PORT_ALTR_16550_F64, },
>  	{ .compatible = "altr,16550-FIFO128",
>  		.data = (void *)PORT_ALTR_16550_F128, },
> +	{ .compatible = "mrvl,mmp-uart",
> +		.data = (void *)PORT_XSCALE, },
> +	{ .compatible = "mrvl,pxa-uart",
> +		.data = (void *)PORT_XSCALE, },
>  #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
>  	{ .compatible = "ibm,qpace-nwp-serial",
>  		.data = (void *)PORT_NWPSERIAL, },
> 
