From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jun 2014 17:33:20 +0100
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <53A9A746.6080200@samsung.com>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com>
Message-ID: <20140624163320.GM9121@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 05:28:54PM +0100, Tomasz Figa wrote:
> Hi Shawn,
> 
> On 22.06.2014 12:15, Shawn Guo wrote:
> > The CP15 diagnostic register holds ARM errata bits on Cortex-A9, so it
> > needs to be saved/restored on suspend/resume.  Otherwise, the
> > effectiveness of errata workaround gets lost together with diagnostic
> > register bit across suspend/resume cycle.
> > 
> > The patch adds a couple of Cortex-A9 specific suspend and resume
> > functions to handle the diagnostic register across suspend/resume cycle.
> 
> [snip]
> 
> > +ENTRY(cpu_ca9mp_do_resume)
> > +	ldmia	r0!, {r4}
> > +	mcr	p15, 0, r4, c15, c0, 1  @ Diagnostic register
> 
> What about platforms running in non-secure mode in which the register is
> read-only?

On A9, it should be write-ignore. Are you seeing problems on a real SoC?

Will
