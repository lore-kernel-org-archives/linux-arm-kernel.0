From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Dec 2013 15:30:15 -0600
Subject: [PATCH v6 5/9] usb: gadget: s3c-hsotg: use generic
 phy_init()/phy_exit() support
In-Reply-To: <20131216212644.GA15814@beef>
References: <1386953483-21631-1-git-send-email-mporter@linaro.org>
 <1386953483-21631-6-git-send-email-mporter@linaro.org>
 <20131216212001.GD12896@saruman.home> <20131216212644.GA15814@beef>
Message-ID: <20131216213015.GI12896@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:26:44PM -0500, Matt Porter wrote:
> On Mon, Dec 16, 2013 at 03:20:01PM -0600, Felipe Balbi wrote:
> > On Fri, Dec 13, 2013 at 11:51:19AM -0500, Matt Porter wrote:
> > > If a generic phy is present, call phy_init()/phy_exit(). This supports
> > > generic phys that must be soft reset before power on.
> > > 
> > > Signed-off-by: Matt Porter <mporter@linaro.org>
> > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >  drivers/usb/gadget/s3c-hsotg.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
> > > index 7c5d8bd..e9683c2 100644
> > > --- a/drivers/usb/gadget/s3c-hsotg.c
> > > +++ b/drivers/usb/gadget/s3c-hsotg.c
> > > @@ -3621,6 +3621,9 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
> > >  		goto err_supplies;
> > >  	}
> > >  
> > > +	if (hsotg->phy)
> > > +		phy_init(hsotg->phy);
> > 
> > doesn't build. you need to include <linux/phy/phy.h>
> 
> It depends on https://lkml.org/lkml/2013/12/5/172 which I noted in the
> cover letter. At this point, I don't know if Kamil's whole series will
> make it to 3.14 so that patch may have to be taken separately. He has a
> trivial update to make on the binding example is all for this patch.
> 
> I was wondering today if we might just want to separate that out now. I
> originally had a similar patch in my series but his was posted first so
> I rebased on that.

I can wait another week tops. By v3.13-rc5 I'm locking my tree down, and
only urgent bugfixes to the next branch will be accepted.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/a641aa93/attachment.sig>
