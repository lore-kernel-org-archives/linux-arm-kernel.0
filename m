From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 09:28:57 +0100
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
In-Reply-To: <1435046411.4528.6.camel@tiscali.nl>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <1435046411.4528.6.camel@tiscali.nl>
Message-ID: <20150623082857.GG3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jun 2015, Paul Bolle wrote:

> On Mon, 2015-06-22 at 16:43 +0100, Lee Jones wrote:
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
>  
> > +config ARM_ST_CPUFREQ
> > +> 	> bool "ST CPUFreq support"
> > +> 	> depends on SOC_STIH407
> > +> 	> help
> > +> 	>   OPP list for cpufreq-dt driver can be provided through DT or can be
> > +> 	>   created at runtime.  Select this if you want create OPP list at runtime.
> 
> 
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> 
> > +obj-$(CONFIG_ARM_ST_CPUFREQ)		+= st-cpufreq.o
> 
> > --- /dev/null
> > +++ b/drivers/cpufreq/st-cpufreq.c
> 
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> > +#include <linux/module.h>
> 
> > +MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
> > 
> > +module_platform_driver(sti_cpufreq);
> 
> > 
> > +MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
> > +MODULE_DESCRIPTION("Creates an OPP list for cpufreq-cpu0 at runtime");
> > +MODULE_LICENSE("GPL v2");
> 
> 
> (There's a mismatch between the license used in the comment at the top
> of this file and the ident used in the MODULE_LICENSE() macro. See
> include/linux/module.h.)
> 
> st-cpufreq.o can only be built-in. But the code contains of few lines
> that are only useful if the code can be modular. Was ARM_ST_CPUFREQ
> perhaps meant to be tristate?

All noted.  Will fix.  Thanks Paul.

BTW, do you have a script that does this now, or are you still
hand-rolling these?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
