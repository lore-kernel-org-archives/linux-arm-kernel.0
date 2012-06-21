From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 21 Jun 2012 16:38:26 +0800
Subject: [PATCH v6 12/14] usb: chipidea: permit driver bindings pass phy
 pointer
In-Reply-To: <4FE2CABE.7050708@pengutronix.de>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <1340260875-21934-13-git-send-email-richard.zhao@freescale.com>
 <4FE2CABE.7050708@pengutronix.de>
Message-ID: <20120621083825.GB1582@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 09:18:22AM +0200, Marc Kleine-Budde wrote:
> On 06/21/2012 08:41 AM, Richard Zhao wrote:
> > Sometimes, the driver bindings may know what phy they use.
> > For example, when using device tree, the usb controller may have a
> > phandler pointing to usb phy.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > Tested-by: Subodh Nijsure <snijsure@grid-net.com>
> 
> [...]
> 
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1684,7 +1684,8 @@ static int udc_start(struct ci13xxx *ci)
> >  
> >  	ci->gadget.ep0 = &ci->ep0in->ep;
> >  
> > -	ci->transceiver = usb_get_transceiver();
> > +	if (ci->global_phy) {
>                            ^^^
> 
> This doesn't compile, closing curly brackets are missing.
> 
Nice catch. 

Thanks
Richard
