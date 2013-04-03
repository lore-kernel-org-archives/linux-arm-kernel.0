From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 03 Apr 2013 10:57:42 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBhdXRjcHUxMjogRml4IGNvbmZpZyBjaGVjayBp?=
 =?UTF-8?B?biBhdXRjcHUxMl9pbml0X2xhdGUoKQ==?=
In-Reply-To: <20130402171217.GE25867@quad.lixom.net>
References: <1363988123.3728.45.camel@deadeye.wl.decadent.org.uk>
 <1364016140.352883792@f399.i.mail.ru>
 <20130402171217.GE25867@quad.lixom.net>
Message-ID: <1364972262.31344533@f56.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Sat, Mar 23, 2013 at 09:22:20AM +0400, Alexander Shiyan wrote:
> > > The 'CONFIG_' prefix is not implicit in IS_ENABLED().
> > > 
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > Cc: Alexander Shiyan <shc_work@mail.ru>
> > > Cc: Olof Johansson <olof@lixom.net>
> > > Cc: Paul Bolle <pebolle@tiscali.nl>
> > > Cc: <stable@vger.kernel.org> # 3.8+
> > > ---
> > > Found by inspection.  This is not even compile-tested.
> > > 
> > > Ben.
> > > 
> > >  arch/arm/mach-clps711x/board-autcpu12.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
> > > index f385847..8138523 100644
> > > --- a/arch/arm/mach-clps711x/board-autcpu12.c
> > > +++ b/arch/arm/mach-clps711x/board-autcpu12.c
> > > @@ -158,7 +158,8 @@ static void __init autcpu12_init(void)
> > >  
> > >  static void __init autcpu12_init_late(void)
> > >  {
> > > -	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
> > > +	if (IS_ENABLED(CONFIG_MTD_NAND_GPIO) &&
> > > +	    IS_ENABLED(CONFIG_GPIO_GENERIC_PLATFORM)) {
> > >  		/* We are need both drivers to handle NAND */
> > >  		platform_device_register(&autcpu12_nand_pdev);
> > >  	}
> > 
> > Oops. Right.
> > And I think checks can be removed completely.
> 
> Seems reasonable -- there's no reason to hold off registering the device just
> because the driver isn't enabled.
> 
> Who'll repost a patch to just remove the tests? Ben? Alexander?

Please apply the patch just yet. I will keep in mind this change.
Thanks.

---
