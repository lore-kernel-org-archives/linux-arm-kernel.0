From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 28 Jan 2015 09:12:07 +0000
Subject: [PATCH v4 00/13] AT91 pm cleanup for 3.20
In-Reply-To: <20150128090602.GA19088@gradator.net>
References: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
 <20150128085913.GA7742@gradator.net> <20150128090602.GA19088@gradator.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD377D3@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: Wednesday, January 28, 2015 5:06 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> peda at axentia.se; sergei.shtylyov at cogentembedded.com; linux at maxim.org.za
> Subject: Re: [PATCH v4 00/13] AT91 pm cleanup for 3.20
> 
> Hello Wenyou,
> 
> On Wed, Jan 28, 2015 at 09:59:13AM +0100, Sylvain Rochet wrote:
> > Hello Wenyou,
> >
> > On Wed, Jan 28, 2015 at 09:39:32AM +0800, Wenyou Yang wrote:
> > > Hi Nicolas,
> > >
> > > This version is rebased on the branch: at91-3.20-cleanup of the repository
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> > >
> > > It is purpose to clean up the PM code, includes the patches from Peter Rosin
> and Sylvain Rochet.
> > >
> > > Since verifying the USB clock and USB PLL disabling before
> > > suspending to memory, it aslo depends on the following patch serials from
> Sylvain:
> > > 	[PATCHv6 0/5] USB: gadget: atmel_usba_udc: Driver improvements
> > > 	[PATCHv7 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
> > >
> > > Removes CONFIG_AT91_SLOW_CLOCK config item to simply the PM config,
> > > The suspend to standby mode uses the same sram function as the suspend to
> memory mode.
> > > Remove some unused code.
> > >
> > > Alexandr & Sylvain, Thank you very much for so many feedbacks.
> > >
> > > Changes in v2:
> > >  - Rebase on the at91-3.20-cleanup branch
> > >  - Recover the verify clock condition, only for suspend to memory.
> > >  - Collect ACK from Alexandre
> > >  - Add the macro for PM mode
> > >
> > > Changes in v3:
> > >  - Clear unused state argument in at91_pm_verify_clocks()
> > >  - Remove pr_info("AT91:... slow_clock ? ..") in patch 07/13.
> >
> > Changes in v4: ? :-)

Yes, I am not careful.

Can I resend?

> 
> Actually, I guess it is:
> 
> Changes in v2:
>  - Rebase on the at91-3.20-cleanup branch
>  - Recover the verify clock condition, only for suspend to memory.
>  - Collect ACK from Alexandre
>  - Add the macro for PM mode
> 
> Changes in v3
>  - Sylvain splits the patch in two
>  - Add handling if no sram allocated for PM
>  - Retain the STANDBY and SUSPEND_MEM select in at91_pm_enter.
> 
> Changes in v4:
>  - Clear unused state argument in at91_pm_verify_clocks()
>  - Remove pr_info("AT91:... slow_clock ? ..") in patch 07/13.
> 
> 
> (I prefer the reverse order, but, details)
> 
> Sylvain

Best Regards,
Wenyou Yang
