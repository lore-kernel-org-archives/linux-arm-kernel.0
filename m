From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Feb 2014 17:55:52 +0000
Subject: [PATCH v9 4/5] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <alpine.DEB.2.02.1402171225000.27926@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
 <1389292336-9292-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1402171225000.27926@kaball.uk.xensource.com>
Message-ID: <20140217175552.GB8361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:25:42PM +0000, Stefano Stabellini wrote:
> On Thu, 9 Jan 2014, Stefano Stabellini wrote:
> > Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
> > Necessary duplication of paravirt.h and paravirt.c with ARM.
> > 
> > The only paravirt interface supported is pv_time_ops.steal_clock, so no
> > runtime pvops patching needed.
> > 
> > This allows us to make use of steal_account_process_tick for stolen
> > ticks accounting.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > CC: will.deacon at arm.com
> > CC: nico at linaro.org
> > CC: marc.zyngier at arm.com
> > CC: cov at codeaurora.org
> > CC: arnd at arndb.de
> > CC: olof at lixom.net
> > CC: Catalin.Marinas at arm.com
> 
> Catalin, Will, are you happy with this patch for 3.15?

It's pretty small and looks fine to me. However, I would like someone
with more virtualisation experience than me to ack it (e.g. Marc Z).

Some nitpicks:

> > +config PARAVIRT
> > +	bool "Enable paravirtualization code"
> > +	---help---
> > +	  This changes the kernel so it can modify itself when it is run
> > +	  under a hypervisor, potentially improving performance significantly
> > +	  over full virtualization.
> > +
> > +config PARAVIRT_TIME_ACCOUNTING
> > +	bool "Paravirtual steal time accounting"
> > +	select PARAVIRT
> > +	default n
> > +	---help---

For consistency with this file, just use "help" rather than
"---help---".

> > --- /dev/null
> > +++ b/arch/arm64/include/asm/paravirt.h
> > @@ -0,0 +1,20 @@
> > +#ifndef _ASM_ARM64_PARAVIRT_H
> > +#define _ASM_ARM64_PARAVIRT_H

__ASM_PARAVIRT_H for consistency.

-- 
Catalin
