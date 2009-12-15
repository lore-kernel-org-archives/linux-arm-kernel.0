From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 15 Dec 2009 12:07:06 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091215191229.GC26422@elf.ucw.cz>
References: <4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz> <4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<1260813293.13078.15.camel@c-dwalke-linux.qualcomm.com>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9C6@mi8nycmail19.Mi8.com>
	<d6200be20912142240q5e7785e6h57fae538a5f4ea4e@mail.gmail.com>
	<20091215191229.GC26422@elf.ucw.cz>
Message-ID: <1260907626.32296.16.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-12-15 at 20:12 +0100, Pavel Machek wrote:
> > > One other thing.  Are the gpio's handled by Pavel's driver actually from the
> > > MSM chip or from an external CPLD?  The registers are all defined as:
> > >
> > > +               .reg = reg_num + DREAM_CPLD_BASE,
> > >
> > > If they are external from the MSM chip this driver should probably be renamed
> > > to something more appropriate since it is probably dream specific and not
> > > generic to the msm architecture.
> > 
> > These are board specific gpios. I think it would be less confusing if
> > the msm gpio support was added first.
> 
> I did not see msm-generic gpios in the trees, where are they? What is
> connected over them?

Did you look at arch/arm/mach-msm/gpio.[ch] ? It looks like there some
idle related code in there, and "SMEM" is connected through that code.
(unless I'm looking at an older tree.)

Daniel
