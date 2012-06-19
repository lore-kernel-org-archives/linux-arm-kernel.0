From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 09:38:49 +0800
Subject: [PATCH] Fixes console on AUART issue for MX28 platform
In-Reply-To: <1340055572-555-1-git-send-email-snijsure@grid-net.com>
References: <1340055572-555-1-git-send-email-snijsure@grid-net.com>
Message-ID: <20120619013847.GA21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 02:39:32PM -0700, Subodh Nijsure wrote:
> 
> Signed-off-by: Subodh Nijsure <snijsure@grid-net.com>

Thanks for the patch, Subodh.

Considering my mxs/for-next is not a stable branch anyway, and we do
not want to bother Greg again to get his ack on this small fix-up,
I just amended the change into Fabio's patch with your sign-off added.

Regards,
Shawn

> ---
>  drivers/tty/serial/mxs-auart.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ca3d25e..2ced332 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -761,7 +761,7 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, s);
>  
> -	auart_port[pdev->id] = s;
> +	auart_port[s->port.line] = s;
>  
>  	mxs_auart_reset(&s->port);
>  
> -- 
> 1.7.5.4
> 
