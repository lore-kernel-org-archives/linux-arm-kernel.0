From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 13 Jan 2011 15:17:43 +0300
Subject: [PATCH] unbreak ehci-mxc on otg port of i.MX27
In-Reply-To: <1294909575-32709-1-git-send-email-eric@eukrea.com>
References: <1294909575-32709-1-git-send-email-eric@eukrea.com>
Message-ID: <4D2EED67.8070904@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-01-2011 12:06, Eric B?nard wrote:

> commit 711669e5b80b6f2d88f61ed8a9681f83d8cbd201 fixed port 0 support
> for i.MX51 but broke it for (at least) i.MX27 which doesn't have
> a usb_phy1 clock but has a pdev->id 0.

> Signed-off-by: Eric B?nard<eric@eukrea.com>
> Cc: Arnaud Patard<arnaud.patard@rtp-net.org>
> Cc: Sascha Hauer<s.hauer@pengutronix.de>
> ---
>   drivers/usb/host/ehci-mxc.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index fa59b26..18eb597 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -178,7 +178,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>   	}
>
>   	/* "dr" device has its own clock */
> -	if (pdev->id == 0) {
> +	if ((cpu_is_mx51()) & (pdev->id == 0)) {

    Why enclose the function call in parens at all? You also don't need parens 
around 'pdev->id == 0'...

WBR, Sergei
