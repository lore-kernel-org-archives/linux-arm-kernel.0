From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 15 Dec 2010 06:40:54 -0800
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <20101215135508.GB8682@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
	<4D08BFFC.3020103@ru.mvista.com>
	<20101215135508.GB8682@huya.qualcomm.com>
Message-ID: <1292424054.13887.5.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-15 at 05:55 -0800, David Brown wrote:
> On Wed, Dec 15, 2010 at 04:17:48PM +0300, Sergei Shtylyov wrote:
> 
> > On 15-12-2010 6:49, Stepan Moskovchenko wrote:
> > 
> > > Add the physical memory offset value for the Qualcomm
> > > MSM8960 chip.
> > 
> > > Signed-off-by: Stepan Moskovchenko<stepanm@codeaurora.org>
> > [...]
> > 
> > > diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
> > > index 070e17d..014bbd3 100644
> > > --- a/arch/arm/mach-msm/include/mach/memory.h
> > > +++ b/arch/arm/mach-msm/include/mach/memory.h
> > > @@ -25,6 +25,8 @@
> > >  #define PHYS_OFFSET		UL(0x00200000)
> > >  #elif defined(CONFIG_ARCH_MSM8X60)
> > >  #define PHYS_OFFSET		UL(0x40200000)
> > > +#elif defined(CONFIG_ARCH_MSM8960)
> > > +#define PHYS_OFFSET		UL(0x40200000)
> > 
> >     Why not:
> > 
> > -#elif defined(CONFIG_ARCH_MSM8X60)
> > +#elif defined(CONFIG_ARCH_MSM8X60) || defined(CONFIG_ARCH_MSM8960)
> 
> I guess it's a matter of style, and what one is trying to emphasize.
> Having each one listed makes it easier to change them individually.
> The file is just a listing of the addresses of each chip, so I don't
> see much reason to try and compact it.

It just shows a deeper issue, that the namespace needs work. There's too
much duplication here vs. 8x60 .. If you look over this whole patchset
it looks very much like 8x60 was just copied over.

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
