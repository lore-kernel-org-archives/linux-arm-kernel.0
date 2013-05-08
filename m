From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 14:12:13 +0200
Subject: [PATCH v2] thermal: cpu_cooling: fix stub function
In-Reply-To: <51829A45.7040307@ti.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <201305021829.37343.arnd@arndb.de> <51829A45.7040307@ti.com>
Message-ID: <201305081412.14201.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Eduardo Valentin wrote:
> Rui, Arnd,
> 
> On 02-05-2013 12:29, Arnd Bergmann wrote:
> > The function stub for cpufreq_cooling_get_level introduced
> > in 57df81069 "Thermal: exynos: fix cooling state translation"
> > is not syntactically correct C and needs to be fixed to avoid
> > this error:
> > 
> > In file included from drivers/thermal/db8500_thermal.c:20:0:
> >  include/linux/cpu_cooling.h: In function 'cpufreq_cooling_get_level':
> > include/linux/cpu_cooling.h:57:1:
> >  error: parameter name omitted  unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)  ^
> >  include/linux/cpu_cooling.h:57:1: error: parameter name omitted
> > 
> > Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Amit Daniel kachhap <amit.daniel@samsung.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

Rui,

Could you please merge that into your thermal/next tree?  Right now,
linux-next fails to build because of this, and you probably don't
want to send the current version to Linus without fixing it.

	Arnd
