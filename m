From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 10 May 2011 19:43:21 +0400
Subject: [PATCH] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <1305037463-10222-1-git-send-email-plagnioj@jcrosoft.com>
References: <1305037463-10222-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4DC95D19.7070707@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Jean-Christophe PLAGNIOL-VILLARD wrote:

> on 9g20 they are the same as the 9261

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  drivers/usb/gadget/at91_udc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index 9b7cdb1..41dc093 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1767,7 +1767,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* newer chips have more FIFO memory than rm9200 */
> -	if (cpu_is_at91sam9260()) {
> +	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {

    These shouldn't be used in the drivers at all.

WBR, Sergei
