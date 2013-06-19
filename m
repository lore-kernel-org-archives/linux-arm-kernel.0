From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 20:18:16 +0200
Subject: [PATCH 08/15] thermal: cpu_cooling: fix stub function
In-Reply-To: <51C1E98B.8030503@ti.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-9-git-send-email-arnd@arndb.de> <51C1E98B.8030503@ti.com>
Message-ID: <201306192018.17125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Eduardo Valentin wrote:
> On 31-05-2013 18:22, Arnd Bergmann wrote:
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
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> 
> What is the status of this patch?
> 
> I believe Rui is supposed to queue this one right?
> 

Yes, that would be good. 3.10 is broken without the patch.

	Arnd
