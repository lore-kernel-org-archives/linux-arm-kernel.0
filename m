From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 16 Apr 2011 11:31:52 +0300
Subject: [PATCH 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <1302942029.2308.1.camel@koala>
References: <1298940450-27365-1-git-send-email-mnalajal@codeaurora.org>
	<1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>
	<1302861097.3220.12.camel@localhost>  <4DA85B24.50807@codeaurora.org>
	<1302942029.2308.1.camel@koala>
Message-ID: <1302942712.2308.3.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-04-16 at 11:20 +0300, Artem Bityutskiy wrote:
> > > +#define MSM_NAND_REG(off) (msm_nand_phys + (off))
> > > +
> > > +#define MSM_NAND_FLASH_CMD            MSM_NAND_REG(0x0000)
> > > +#define MSM_NAND_ADDR0                MSM_NAND_REG(0x0004)
> > >
> > > Could you please make the macros to take the "struct msm_nand_chip
> > > *chip" argument instead, and store the pase address there. Do not hide
> > > the fact that those macros are actually functions, not constant - this
> > > is error prone.
> > >
> > > Besides, I'm do not know your HW, but if you have several controllers
> > > with various base addresses - your driver won't work.
> > 
> > you are correct, we have multiple controllers, which breaks this logic 
> > in future.
> 
> So then make your macros to accept the base address as an argument
> instead please.

Or better make macros to be constants, and always use something like
base + MSM_NAND_FLASH_CMD - this is the standard approach.
-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
