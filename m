From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Nov 2011 17:02:30 +0000
Subject: [PATCH v7 11/16] ARM: LPAE: Add fault handling support
In-Reply-To: <20111023115756.GB17912@n2100.arm.linux.org.uk>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-12-git-send-email-catalin.marinas@arm.com>
	<20111023115756.GB17912@n2100.arm.linux.org.uk>
Message-ID: <20111102170230.GJ29782@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 12:57:56PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 04:03:34PM +0100, Catalin Marinas wrote:
> > @@ -494,6 +508,72 @@ static struct fsr_info {
> >  	int	code;
> >  	const char *name;
> >  } fsr_info[] = {
> > +#ifdef CONFIG_ARM_LPAE
...
> > +#else	/* !CONFIG_ARM_LPAE */
> >  	/*
> >  	 * The following are the standard ARMv3 and ARMv4 aborts.  ARMv5
> >  	 * defines these to be "precise" aborts.
> > @@ -535,6 +615,7 @@ static struct fsr_info {
> >  	{ do_bad,		SIGBUS,  0,		"unknown 29"			   },
> >  	{ do_bad,		SIGBUS,  0,		"unknown 30"			   },
> >  	{ do_bad,		SIGBUS,  0,		"unknown 31"			   }
> > +#endif	/* CONFIG_ARM_LPAE */
> 
> Can't we do better than this?

The first thought was defining the fsr_info array in a different file
but that would mean exposing functions from the fault.c which are
currently defined as static.

The other variant is including a C file directly in fault.c. It's not
very nice but at least we remove the big #ifdef.

-- 
Catalin
