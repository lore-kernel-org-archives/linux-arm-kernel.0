From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:22:14 +0900
Subject: [PATCH 05/16] ARM: S5PC100: new clocks definition
In-Reply-To: <003001caf1fb$64b5ecd0$2e21c670$%szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
	<001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
	<003001caf1fb$64b5ecd0$2e21c670$%szyprowski@samsung.com>
Message-ID: <003a01caf232$59cb6930$0d623b90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> On Wednesday, May 12, 2010 6:57 AM Kukjin Kim wrote:
> 
> > Marek Szyprowski wrote:
> > >
> > > Prepare for moving support for S5PC100 SoC to plat-s5p framework (part
3).
> > > This patch adds all clocks from plat-s5pc1xx/clocks.c and removes all
the
> > > code that can be reused from plat-s5p/clock.c.
> > >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  arch/arm/mach-s5pc100/clock.c                      |  841
> > > ++++++++++++++++----
> > >  .../include/mach}/regs-clock.h                     |    0
> > >  2 files changed, 703 insertions(+), 138 deletions(-)
> > >  copy arch/arm/{plat-s5pc1xx/include/plat =>
> > mach-s5pc100/include/mach}/regs-
> > > clock.h (100%)
> > >

(snip)

> >
> > This is not correct. If you use structure of clksrc_clk, you can handle
> > this
> > easily. So no need this function.
> 
> clksrc_clk cannot be used for armclk. You define it in a similar way in
> mach-s5p6440/clock.c
> 
> > ...
> 
> > > @@ -773,6 +812,11 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
> > >  	unsigned int ptr;
> > >  	u32 clkdiv0, clkdiv1;
> > >
> > > +	/* Hook callbacks to base clocks */
> > > +	clk_48m.enable = s5pc100_clk_48m_ctrl;
> > > +	clk_arm.ops = &s5pc100_armclk_ops;
> >
> > No need to register ops member.
> 
> Please check mach-s5p6440/clock.c, it is done exactly the same way.
> 

Hi, 

The new 6440 clock patches use clksrc_clk struct.
For armclk also. And many other clocks also.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
