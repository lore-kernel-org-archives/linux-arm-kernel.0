From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 18 Jan 2015 01:22:38 +0300
Subject: [PATCHv3 1/5] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <1421529942-18437-2-git-send-email-sylvain.rochet@finsecur.com>
References: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
 <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421529942-18437-2-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54BAE0AE.5060705@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/18/2015 12:25 AM, Sylvain Rochet wrote:

    There's little inconsistency in your patch subjects: you're using '_' but 
the files you're modifying are named using '-'...

> This patch add suspend/resume support for Atmel EHCI, mostly
> about disabling and unpreparing clocks so USB PLL is stopped
> before entering sleep state.

> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>   drivers/usb/host/ehci-atmel.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 56a8850..2e0043b 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
[...]
> @@ -187,6 +217,8 @@ static struct platform_driver ehci_atmel_driver = {
>   	.probe		= ehci_atmel_drv_probe,
>   	.remove		= ehci_atmel_drv_remove,
>   	.shutdown	= usb_hcd_platform_shutdown,
> +	.suspend	= ehci_atmel_drv_suspend,
> +	.resume		= ehci_atmel_drv_resume,

    I think you should use 'struct dev_pm_ops' now.

WBR, Sergei
