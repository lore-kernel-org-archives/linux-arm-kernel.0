From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 3 Dec 2012 11:51:24 -0500 (EST)
Subject: [PATCH] nommu: Enable the strict alignment (CR_A) bit only if
 ARCH < v6
In-Reply-To: <50BCD6DB.2030200@st.com>
References: <1354187042-28568-1-git-send-email-armando.visconti@st.com>
 <50BCD6DB.2030200@st.com>
Message-ID: <alpine.LFD.2.02.1212031150580.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Dec 2012, Armando Visconti wrote:

> On 11/29/2012 12:04 PM, Armando VISCONTI wrote:
> > This patch keeps disabled the strict alignment CP15 bit for
> > all armv6 and armv7 processor without the mmu. This behaviour
> > is now same as in the mmu case.
> > 
> > Signed-off-by: Armando Visconti<armando.visconti@st.com>
> > ---
> >   arch/arm/kernel/head-nommu.S |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> > index 278cfc1..2c228a0 100644
> > --- a/arch/arm/kernel/head-nommu.S
> > +++ b/arch/arm/kernel/head-nommu.S
> > @@ -68,7 +68,7 @@ __after_proc_init:
> >   	 * CP15 system control register value returned in r0 from
> >   	 * the CPU init function.
> >   	 */
> > -#ifdef CONFIG_ALIGNMENT_TRAP
> > +#if defined(CONFIG_ALIGNMENT_TRAP)&&  __LINUX_ARM_ARCH__<  6
> >   	orr	r0, r0, #CR_A
> >   #else
> >   	bic	r0, r0, #CR_A
> 
> Any feedback on this simple patch?

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
