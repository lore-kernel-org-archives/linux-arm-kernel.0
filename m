From: greg@kroah.com (Greg KH)
Date: Tue, 30 Nov 2010 10:48:34 -0800
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <20101130184049.GC8521@n2100.arm.linux.org.uk>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<201011261224.59490.arnd@arndb.de>
	<AANLkTinCYdb8p4-H+Aki-z+i7ZL2ETwGJdDxOQ4XpBJ+@mail.gmail.com>
	<201011301621.48140.arnd@arndb.de>
	<20101130184049.GC8521@n2100.arm.linux.org.uk>
Message-ID: <20101130184834.GA16055@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 06:40:49PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 30, 2010 at 04:21:47PM +0100, Arnd Bergmann wrote:
> > On Tuesday 30 November 2010, Linus Walleij wrote:
> > > 2010/11/26 Arnd Bergmann <arnd@arndb.de>:
> > > 
> > > > * When you say that the devices are static, I hope you do not mean
> > > >  static in the C language sense. We used to allow devices to be
> > > >  declared as "static struct" and registered using
> > > >  platform_device_register (or other bus specific functions). This
> > > >  is no longer valid and we are removing the existing users, do not
> > > >  add new ones. When creating a platform device, use
> > > >  platform_device_register_simple or platform_device_register_resndata.
> > > 
> > > Is this part of the generic ARM runtime multi-platform kernel
> > > and device trees shebang?
> > > 
> > > The Ux500 still isn't in that sector, it needs extensive rewriting
> > > of arch/arm/mach-ux500 to be done first, so as to support e.g.
> > > U8500 and U5500 with a single kernel image.
> > > 
> > > Trying to skin that cat that as part of this review is a bit too
> > > much to ask IMO, I'd rather have the author of this driver
> > > adapt to whatever platform data registration mechanism is
> > > in place for the merge window. Else it needs fixing as part
> > > of a bigger endavour to root out compile-time platform
> > > configuration.
> > 
> > The 'no static devices' rule is something that Greg brought up
> > at the embedded developer session during PlumbersConf this year,
> > I wasn't aware of the problem before that either.
> > 
> > It is not related to the multi-platform kernel work and it's
> > not ARM specific.
> > 
> > Maybe Greg can give a short explanation of the impact of this.
> > AFAIR, static device definitions still work, but there are
> > plans to remove that capability in the future.
> 
> There's lots of static devices, not only platform devices, in the ARM
> tree.  It's going to be a hell of a lot of work to fix this all up
> properly.

I agree, it's been abused for many years this way :(

> I hope that the capability for static devices won't disappear until
> the huge pile of work on ARM has been completed.

Don't worry, it will not.

thanks,

greg k-h
