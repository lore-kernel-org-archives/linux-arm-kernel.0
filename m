From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 17 Jan 2013 12:19:10 +1300
Subject: [PATCH] tty: serial/vt8500_serial.c: fix bug caused by missing
 "{}"
In-Reply-To: <1358375103-11703-1-git-send-email-dinggnu@gmail.com>
References: <1358375103-11703-1-git-send-email-dinggnu@gmail.com>
Message-ID: <1358378350.7405.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 23:25 +0100, Cong Ding wrote:
> It is obviously here should be braced by "{}" in the "if" branch (more than 1
> line in the "if" branch), and by the
> coding style document of the kernel I also add "{}" to the else branch.
> 
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> ---
>  drivers/tty/serial/vt8500_serial.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 8fd1814..ac46a6e 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -567,12 +567,13 @@ static int vt8500_serial_probe(struct platform_device *pdev)
>  	if (!mmres || !irqres)
>  		return -ENODEV;
>  
> -	if (np)
> +	if (np) {
>  		port = of_alias_get_id(np, "serial");
>  		if (port > VT8500_MAX_PORTS)
>  			port = -1;
> -	else
> +	} else {
>  		port = -1;
> +	}
>  
>  	if (port < 0) {
>  		/* calculate the port id */

Correct. This patch is good but unnecessary now as the patch series I
pushed out removes this code anyway.

It should be applied if the series I sent out is not accepted in this
merge windows.

Regards
Tony P
