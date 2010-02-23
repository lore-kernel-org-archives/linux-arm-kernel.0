From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 23 Feb 2010 10:36:08 -0800
Subject: [RFC PATCH 05/12] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1264763482.4242.50.camel@pc1117.cambridge.arm.com>
References: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
	<1264763482.4242.50.camel@pc1117.cambridge.arm.com>
Message-ID: <1266950168.24069.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 11:11 +0000, Catalin Marinas wrote:
> On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 10e0680..bea3e75 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> [...]
> >  static struct fsr_info {
> >         int     (*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
> >         int     sig;
> > @@ -479,7 +513,7 @@ static struct fsr_info {
> >         { do_bad,               SIGBUS,  0,             "unknown 19"                       },
> >         { do_bad,               SIGBUS,  0,             "lock abort"                       }, /* xscale */
> >         { do_bad,               SIGBUS,  0,             "unknown 21"                       },
> > -       { do_bad,               SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */
> > +       { do_imprecise_ext,     SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */
> 
> Can you not use hook_fault_code() and move the do_imprecise_ext() to a
> platform-specific file (under arch/arm/mach-* maybe)?
> 

How do you mean? I'm not sure how we would move this into
arch/arm/mach- ..

Daniel
