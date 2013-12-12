From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 11:48:38 -0600
Subject: [PATCH v3 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <52A72F28.10909@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-2-git-send-email-w-kwok2@ti.com>
 <20131210025110.GA20090@saruman.home> <52A72F28.10909@ti.com>
Message-ID: <20131212174838.GE1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 10, 2013 at 10:11:36AM -0500, Santosh Shilimkar wrote:
> >> +static int kdwc3_remove(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> >> +
> >> +	kdwc3_disable_irqs(kdwc);
> >> +	clk_disable_unprepare(kdwc->clk);
> > 
> > I hope the clock isn't shared between core and wrapper, otherwise you
> > could run into some troubles here. Can you confirm ?
> > 
> Yes. the clock isn't shared. Thanks for taking care of other parts.

so clock for core is always running too ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/ec33f2df/attachment.sig>
