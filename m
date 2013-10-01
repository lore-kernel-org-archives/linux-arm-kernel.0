From: balbi@ti.com (Felipe Balbi)
Date: Tue, 1 Oct 2013 09:22:40 -0500
Subject: [PATCH usb 1/2] usb: musb: Add missing ATOMIC_INIT_NOTIFIER_HEAD
In-Reply-To: <20130926000059.GA25716@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <20130918164816.GN21559@radagast> <201309181903.33243@pali>
 <201309251017.39014@pali> <20130925203333.GU10746@radagast>
 <20130926000059.GA25716@amd.pavel.ucw.cz>
Message-ID: <20131001142240.GR1476@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 26, 2013 at 02:00:59AM +0200, Pavel Machek wrote:
> > On Wed, Sep 25, 2013 at 10:17:38AM +0200, Pali Roh?r wrote:
> > > On Wednesday 18 September 2013 19:03:33 Pali Roh?r wrote:
> > > > &twl->phy.notifier is not initalized
> > > > 
> > > > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > > > 
> > > > diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> > > > b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> > > > 100644
> > > > --- a/drivers/usb/phy/phy-twl4030-usb.c
> > > > +++ b/drivers/usb/phy/phy-twl4030-usb.c
> > > > @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> > > > platform_device *pdev) if (device_create_file(&pdev->dev,
> > > > &dev_attr_vbus)) dev_warn(&pdev->dev, "could not create sysfs
> > > > file\n");
> > > > 
> > > > +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> > > > +
> > > >  	/* Our job is to use irqs and status from the power module
> > > >  	 * to keep the transceiver disabled when nothing's
> > > > connected. *
> > > 
> > > I sent above patch week ago. Did you already included it?
> > 
> > look at my testing branch.
> 
> Felipe prefers you to go MAINTAINERS file for
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
> 
> entry. After few clicks, you'll find out your two patches in 
> 
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=testing
> 
> . So yes, it seems that after 10+ flames Felipe was _not_ lazy to
> send, "Thanks for a patch" mail was too much work.
> 
> Apparently, we'll need  Documentation/HowToBeGoodMaintainer file...

I only send my automated emails after properly testing them. They sit in
'testing' for as long as necessary. After all the test is done, they'll
be moved to 'next' at which point you get your email notification and
they reach linux-next for the next day.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/529e96bf/attachment-0001.sig>
