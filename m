From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Jun 2013 15:20:20 +0100
Subject: [PATCH 2/4] mfd: dbx500-prcmu: Correctly reorder PRCMU clock
 identifiers
In-Reply-To: <CACRpkdYLB-_JjEd69vVub_Z3L+avQRrFBt1fGuyR0D_owcLWvA@mail.gmail.com>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <1370517676-10909-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdYLB-_JjEd69vVub_Z3L+avQRrFBt1fGuyR0D_owcLWvA@mail.gmail.com>
Message-ID: <20130607142020.GB24958@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Jun 2013, Linus Walleij wrote:

> On Thu, Jun 6, 2013 at 1:21 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > ... as stipulated by the Hardware Specification document.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I think you need Ulf (as ux500 clock author) and Loic (as PRCMU
> developer) to have a look at this.
> 
> > -enum prcmu_clock {
> > -       PRCMU_SGACLK,
> (...)
> > +#define ARMCLK                 0
> > +#define PRCMU_ACLK             1
> (...)
> 
> It seems the enum and the defines want to do two different things?
> 
> The first is a kernel-internal representation of the clocks, whereas
> the latter is a HW-centric representation for a certain PRCMU
> variant (I guess?)
> 
> Does one actually exclude the other?

>From what I can tell, they're non-ordered values which are used as
read-ins to the clk_mgt array. So long as they are unique I'm not sure
the order matters. The current order seems 'made up', unless I'm
mistaken.

I agree that Ulf should take a look and confirm/deny my findings.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
