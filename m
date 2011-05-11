From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 05:18:54 +0200
Subject: [PATCH] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <20110511015829.GB6840@kroah.com>
References: <1305037463-10222-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC95D19.7070707@ru.mvista.com>
	<20110510155038.GJ18791@game.jcrosoft.org>
	<20110510170500.GB15675@kroah.com>
	<20110510235324.GD18929@game.jcrosoft.org>
	<20110511015829.GB6840@kroah.com>
Message-ID: <20110511031854.GF18929@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:58 Tue 10 May     , Greg KH wrote:
> On Wed, May 11, 2011 at 01:53:24AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 10:05 Tue 10 May     , Greg KH wrote:
> > > On Tue, May 10, 2011 at 05:50:38PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 19:43 Tue 10 May     , Sergei Shtylyov wrote:
> > > > > Hello.
> > > > > 
> > > > > Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > 
> > > > > >on 9g20 they are the same as the 9261
> > > > > 
> > > > > >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > > > >---
> > > > > > drivers/usb/gadget/at91_udc.c |    2 +-
> > > > > > 1 files changed, 1 insertions(+), 1 deletions(-)
> > > > > 
> > > > > >diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> > > > > >index 9b7cdb1..41dc093 100644
> > > > > >--- a/drivers/usb/gadget/at91_udc.c
> > > > > >+++ b/drivers/usb/gadget/at91_udc.c
> > > > > >@@ -1767,7 +1767,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
> > > > > > 	}
> > > > > > 	/* newer chips have more FIFO memory than rm9200 */
> > > > > >-	if (cpu_is_at91sam9260()) {
> > > > > >+	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {
> > > > > 
> > > > >    These shouldn't be used in the drivers at all.
> > > > Sorry this is a bug fix for the current rc and 2.6.38 and older stable tree
> > > 
> > > How could I apply this to the tree for the .40 release then?
> > it's also the case these patch apply from kernel v2.6.26 to above
> > 
> > for the 2.6.40 we will rewrite the soc init so we may chane this in .40 or .41
> 
> That makes no sense, how can I go back in time and apply this to an
> older kernel version?
I known we just need for the longterm and stable tree
and the .39-rc8
> 
> Please provide a patch that I can apply against the linux-next tree if
> you want this change to be accepted.
it's appy to the -next

Best Regards,
J.
