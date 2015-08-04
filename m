From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 4 Aug 2015 17:00:59 +0800
Subject: [RFC PATCH 2/3] mailbox: Hisilicon: add mailbox driver
In-Reply-To: <20150804084930.GA27609@leoy-linaro>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
 <1438564390-28111-3-git-send-email-leo.yan@linaro.org>
 <1438677024.8734.24.camel@tiscali.nl>
 <20150804084930.GA27609@leoy-linaro>
Message-ID: <20150804090059.GB27609@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Aug 04, 2015 at 04:49:30PM +0800, Leo Yan wrote:
> On Tue, Aug 04, 2015 at 10:30:24AM +0200, Paul Bolle wrote:
> > (This RFC was part of this mornings catch of my crude mail filter. So,
> > for what it's worth, what follows are a few random comments for the few
> > things I'm able to spot.)

[...]

> > > +static int __init hi6220_mbox_init(void)
> > > +{
> > > +	return platform_driver_register(&hi6220_mbox_driver);
> > > +}
> > > +module_init(hi6220_mbox_init);
> > > +
> > > +static void __exit hi6220_mbox_exit(void)
> > > +{
> > > +	platform_driver_unregister(&hi6220_mbox_driver);
> > > +}
> > > +module_exit(hi6220_mbox_exit);
> > 
> > This could be flattened into one line:
> >     module_platform_driver(hi6220_mbox_driver);

Need clarify one thing: will modify to use core_initcall() for driver's
initialization; due another clock driver depends on this mailbox driver,
so mailbox init firstly with core_initcall() and use subsys_initcall()
for clock driver.

Thanks,
Leo Yan
