From: tixy@yxit.co.uk (Tixy)
Date: Tue, 30 Aug 2011 08:16:50 +0100
Subject: [PATCH 01/10] ARM: kprobes: Add config option for selecting
	the ARM kprobes tests
In-Reply-To: <alpine.LFD.2.00.1108291431300.20358@xanadu.home>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
	<1314621249-958-2-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1108291431300.20358@xanadu.home>
Message-ID: <1314688610.2371.12.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-29 at 14:44 -0400, Nicolas Pitre wrote:
> On Mon, 29 Aug 2011, Tixy wrote:
> 
> > From: Jon Medhurst <tixy@yxit.co.uk>
> > 
> > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > ---
> >  arch/arm/Kconfig.debug |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 81cbe40..8f95417 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -129,4 +129,14 @@ config DEBUG_S3C_UART
> >  	  The uncompressor code port configuration is now handled
> >  	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
> >  
> > +config ARM_KPROBES_TESTS
> > +	bool
> > +
> > +config ARM_KPROBES_TEST_MODULE
> > +	tristate "Kprobes test module"
> > +	depends on KPROBES && MODULES
> > +	select ARM_KPROBES_TESTS
> > +	help
> > +	  "Perform tests of kprobes API and instruction set simulation"
> > +
> 
> Why do you need two config symbols here? Isn't ARM_KPROBES_TEST_MODULE 
> redundant?

When ARM_KPROBES_TEST_MODULE is configured for a stand-alone module,
rather than built-in, then

#ifdef CONFIG_ARM_KPROBES_TEST_MODULE

is false. I found other examples where people seemed to have gotten
around this by selecting a second config symbol and copied that. E.g.
FTRACE_STARTUP_TEST selects FTRACE_SELFTEST which is then used in #ifdef
statements.

Is there a better way? If not, I should explain this anyway in the
changelog.

-- 
Tixy
