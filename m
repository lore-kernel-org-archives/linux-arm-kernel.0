From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Dec 2010 09:54:46 -0000
Subject: Forced HW_BREAKPOINT
In-Reply-To: <4CF58F22.6070803@ti.com>
References: <4CF58F22.6070803@ti.com>
Message-ID: <004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyril,

> I am running an ARM1176JZ-S based SoC, on which HW breakpoints do not
> seem to function for some reason.

What are the symptoms that you are seeing? The 1176 has debug architecture
v6.1 so it should be supported by the code.
 
> Unfortunately the current Kconfig forces HW_BREAKPOINT if PERF_EVENTS is
> enabled on ARMV6 (commit 19852e59002fbba1c2c6ba0f154095a37ad2ac03):
> 
> > +       select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
> 
> As a result, I am unable to use the PMU for OProfile, without having hw
> breakpoints barf at boot.  Is there any dependency between h/w
> breakpoints and PMU that I am missing?  If not, does H/W breakpoints
> have be forced here?

The hw_breakpoint code depends on 1.) perf and 2.) hardware debug capabilities.
Since all v6 and v7 cores are supported (at least, everything should fail
gracefully if something is awry) then I don't see the point in not having it
enabled. However, if this is causing your board to break during boot we
should either fix it or allow it to be turned off.

Can you give me some more details about how it breaks please as I don't
have an 1176 that I can get my hands on?

Thanks,

Will
