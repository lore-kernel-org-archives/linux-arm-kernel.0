From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 27 Sep 2016 12:57:48 +0200
Subject: [PATCH 5/5] tty: amba-pl011: Add earlycon support for SBSA UART
In-Reply-To: <1474708465-38958-6-git-send-email-wangkefeng.wang@huawei.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
 <1474708465-38958-6-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160927105748.GA3847@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 05:14:25PM +0800, Kefeng Wang wrote:
> Declare an OF early console for SBSA UART so that the early console device
> can be specified via the "stdout-path" property in device-tree.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 7d9b291..3688d3b 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2330,6 +2330,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>  	return 0;
>  }
>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
> +OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);

Why do you need another option for the same thing?

confused,

greg k-h
