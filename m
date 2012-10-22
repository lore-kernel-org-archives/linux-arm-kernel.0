From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 22 Oct 2012 14:07:06 +0200
Subject: [PATCH 2/3] PWM: vt8500: Update vt8500 PWM driver support
In-Reply-To: <201210221150.22004.arnd@arndb.de>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
 <1350888712.3592.11.camel@gitbox>
 <20121022071118.GA30026@avionic-0098.mockup.avionic-design.de>
 <201210221150.22004.arnd@arndb.de>
Message-ID: <20121022120706.GA19467@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 11:50:21AM +0000, Arnd Bergmann wrote:
> On Monday 22 October 2012, Thierry Reding wrote:
> > On Mon, Oct 22, 2012 at 07:51:52PM +1300, Tony Prisk wrote:
> > > Replies to your comments inline:
> > > 
> > > On Mon, 2012-10-22 at 08:34 +0200, Thierry Reding wrote:
> > > ...
> > > > > -static int __devinit pwm_probe(struct platform_device *pdev)
> > > > > +static const struct of_device_id vt8500_pwm_dt_ids[] = {
> > > > > + { .compatible = "via,vt8500-pwm", },
> > > > > + { /* Sentinel */ }
> > > > > +};
> > > > > +
> > > > > +static int __devinit vt8500_pwm_probe(struct platform_device *pdev)
> > > > 
> > > > Since you're changing this line anyway, maybe you should drop __devinit
> > > > (and __devexit for the .remove() callback). HOTPLUG is always enabled
> > > > nowadays and will go away eventually, in which case these will need to
> > > > be removed anyway.
> > > 
> > > Will do. I must say the inconstancy among comments is rather
> > > frustrating. In another patch I sent out a few days ago (completely
> > > unrelated to this), I told to add __devexit to a remove() function :\
> > 
> > This is a rather recent development, so maybe not everyone knows about
> > it yet. You can look at the following commit for the details:
> > 
> >         45f035ab9b8f45aaf1eb2213218b7e9c14af3fc2
> > 
> > It's been in linux-next for about 6 weeks and has also gone into
> > 3.7-rc1.
> 
> As long as we get build warnings for leaving out the __devinit/__devexit
> annotations, I would generally recommend putting them in. If we do a
> patch to remove all of them, a couple extra instances will not cause
> any more troubles than we already have.

I've never seen any build warnings for leaving __devinit/__devexit out.
Where does that happen?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/1edd4237/attachment.sig>
