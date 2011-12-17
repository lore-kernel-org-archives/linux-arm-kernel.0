From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Dec 2011 22:24:55 -0500 (EST)
Subject: buggy usage of pm_idle by omap1 code
Message-ID: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I just noticed in mach-omap1/cpu.c:omap_pm_prepare() that the function 
pointer pm_idle is explicitly set to NULL for some vague reason.  
However this pointer is unconditionally dereferenced in 
kernel/process.c:cpu_idle().  This is just a oops waiting to happen.  
And if it doesn't happen in practice, then the code in omap_pm_prepare() 
must be useless in addition to being wrong.


Nicolas
