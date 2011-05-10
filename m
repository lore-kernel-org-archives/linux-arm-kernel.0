From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 17:50:38 +0200
Subject: [PATCH] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <4DC95D19.7070707@ru.mvista.com>
References: <1305037463-10222-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC95D19.7070707@ru.mvista.com>
Message-ID: <20110510155038.GJ18791@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:43 Tue 10 May     , Sergei Shtylyov wrote:
> Hello.
> 
> Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> >on 9g20 they are the same as the 9261
> 
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >---
> > drivers/usb/gadget/at91_udc.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> >diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> >index 9b7cdb1..41dc093 100644
> >--- a/drivers/usb/gadget/at91_udc.c
> >+++ b/drivers/usb/gadget/at91_udc.c
> >@@ -1767,7 +1767,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
> > 	}
> > 	/* newer chips have more FIFO memory than rm9200 */
> >-	if (cpu_is_at91sam9260()) {
> >+	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {
> 
>    These shouldn't be used in the drivers at all.
Sorry this is a bug fix for the current rc and 2.6.38 and older stable tree

if you take a look on other patch on the ML you will see some work done here

Best Regards,
J.
