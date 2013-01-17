From: rtivy@ti.com (Tivy, Robert)
Date: Thu, 17 Jan 2013 17:46:45 +0000
Subject: [PATCH v5 5/9] ARM: davinci: New reset functionality/API
 provided for Davinci DSP
In-Reply-To: <50F7E17C.1040607@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-6-git-send-email-rtivy@ti.com> <50F7E17C.1040607@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431205783@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou for all your help Sekhar.  I'm fine with your fixups (both commentary and code naming).

Regards,

- Rob

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Thursday, January 17, 2013 3:33 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark; ohad at wizery.com;
> rob at landley.net; linux-doc at vger.kernel.org
> Subject: Re: [PATCH v5 5/9] ARM: davinci: New reset functionality/API
> provided for Davinci DSP
> 
> On 1/11/2013 5:53 AM, Robert Tivy wrote:
> > Since there is no general "reset" support for SoC devices, and since
> the
> > remoteproc driver needs explicit control of the DSP's reset line, a
> new
> > Davinci-specific API is added.
> >
> > This private API will disappear with DT migration.  Some discussion
> > regarding a proposed DT "reset" binding is here:
> > https://patchwork.kernel.org/patch/1635051/
> >
> > Modified davinci_clk_init() to set clk "reset" function for clocks
> > that indicate PSC_LRST support.  Also fixed indentation issue with
> > function opening curly brace.
> >
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> 
> I applied this patch for v3.9. The subject seemed too long with
> repeated
> references to davinci so I shortened it to:
> 
> ARM: davinci: psc: introduce reset API
> 
> > --- a/arch/arm/mach-davinci/include/mach/psc.h
> > +++ b/arch/arm/mach-davinci/include/mach/psc.h
> > @@ -246,6 +246,7 @@
> >
> >  #define MDSTAT_STATE_MASK	0x3f
> >  #define PDSTAT_STATE_MASK	0x1f
> > +#define MDCTL_LRST		BIT(8)
> >  #define MDCTL_FORCE		BIT(31)
> >  #define PDCTL_NEXT		BIT(0)
> >  #define PDCTL_EPCGOOD		BIT(8)
> > @@ -253,6 +254,8 @@
> >  #ifndef __ASSEMBLER__
> >
> >  extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int
> id);
> > +extern void davinci_psc_reset_config(unsigned int ctlr, unsigned int
> id,
> > +		bool reset);
> 
> I felt the word 'config' in the name is not really required since the
> functionality is fixed (as opposed to the davinci_psc_config() function
> which could do multiple configurations)
> 
> I updated the function name to davinci_psc_reset() when I committed the
> patch locally.
> 
> Hope that's okay with you.
> 
> Thanks,
> Sekhar
