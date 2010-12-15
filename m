From: davidb@codeaurora.org (David Brown)
Date: Wed, 15 Dec 2010 05:55:08 -0800
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <4D08BFFC.3020103@ru.mvista.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
	<4D08BFFC.3020103@ru.mvista.com>
Message-ID: <20101215135508.GB8682@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 04:17:48PM +0300, Sergei Shtylyov wrote:

> On 15-12-2010 6:49, Stepan Moskovchenko wrote:
> 
> > Add the physical memory offset value for the Qualcomm
> > MSM8960 chip.
> 
> > Signed-off-by: Stepan Moskovchenko<stepanm@codeaurora.org>
> [...]
> 
> > diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
> > index 070e17d..014bbd3 100644
> > --- a/arch/arm/mach-msm/include/mach/memory.h
> > +++ b/arch/arm/mach-msm/include/mach/memory.h
> > @@ -25,6 +25,8 @@
> >  #define PHYS_OFFSET		UL(0x00200000)
> >  #elif defined(CONFIG_ARCH_MSM8X60)
> >  #define PHYS_OFFSET		UL(0x40200000)
> > +#elif defined(CONFIG_ARCH_MSM8960)
> > +#define PHYS_OFFSET		UL(0x40200000)
> 
>     Why not:
> 
> -#elif defined(CONFIG_ARCH_MSM8X60)
> +#elif defined(CONFIG_ARCH_MSM8X60) || defined(CONFIG_ARCH_MSM8960)

I guess it's a matter of style, and what one is trying to emphasize.
Having each one listed makes it easier to change them individually.
The file is just a listing of the addresses of each chip, so I don't
see much reason to try and compact it.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
