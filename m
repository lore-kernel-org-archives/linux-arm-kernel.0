From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Feb 2012 04:25:03 +0100
Subject: [PATCH v2 02/19] ARM: at91/at91x40: remove use of
 at91_sys_read/write
In-Reply-To: <4F456AAF.3090809@gmail.com>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <fac36a5ab9fe5a8bd977d2305eeccad48389cbb5.1329903206.git.nicolas.ferre@atmel.com>
 <4F456AAF.3090809@gmail.com>
Message-ID: <20120223032503.GA20176@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:22 Thu 23 Feb     , Ryan Mallon wrote:
> On 22/02/12 20:39, Nicolas Ferre wrote:
> 
> > From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  arch/arm/mach-at91/at91x40.c              |    2 +-
> >  arch/arm/mach-at91/at91x40_time.c         |   28 +++++++++++++++++-----------
> >  arch/arm/mach-at91/include/mach/at91x40.h |   18 +++++++++---------
> >  3 files changed, 27 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
> > index 0154b7f..5400a1d 100644
> > --- a/arch/arm/mach-at91/at91x40.c
> > +++ b/arch/arm/mach-at91/at91x40.c
> > @@ -44,7 +44,7 @@ static void at91x40_idle(void)
> >  	 * Disable the processor clock.  The processor will be automatically
> >  	 * re-enabled by an interrupt or by a reset.
> >  	 */
> > -	at91_sys_write(AT91_PS_CR, AT91_PS_CR_CPU);
> > +	__raw_writel(AT91_PS_CR_CPU, AT91_PS_CR);
> 
> 
> This doesn't seem to be equivalent, at91_sys_write does:
> 
>   void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
>   __raw_writel(value, addr + reg_offset);
> 
> and this patch doesn't redefine AT91_PS_CR. Was it broken before this
> patch? What am I missing?
this is right
#define AT91_PS_CR      (AT91_PS + 0)   /* PS Control register */

Best Regards,
J.
