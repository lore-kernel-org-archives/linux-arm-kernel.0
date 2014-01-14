From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Jan 2014 08:04:40 -0600
Subject: [PATCHv4 6/7] hwspinlock/omap: enable module before reading
 SYSSTATUS register
In-Reply-To: <20140114131052.GA10818@saruman.home>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-7-git-send-email-s-anna@ti.com>
 <20140114131052.GA10818@saruman.home>
Message-ID: <20140114140440.GA15785@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Tue, Jan 14, 2014 at 07:10:52AM -0600, Felipe Balbi wrote:
> > diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> > index 9f56fb2..194886e 100644
> > --- a/drivers/hwspinlock/omap_hwspinlock.c
> > +++ b/drivers/hwspinlock/omap_hwspinlock.c
> > @@ -101,10 +101,23 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
> >  	if (!io_base)
> >  		return -ENOMEM;
> >  
> > +	/*
> > +	 * make sure the module is enabled and clocked before reading
> > +	 * the module SYSSTATUS register
> > +	 */
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_get_sync(&pdev->dev);

another thing, you need to check return of pm_runtime_get_sync()

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/6ca61f80/attachment.sig>
