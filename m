From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 19 Nov 2014 00:32:39 +0100
Subject: [PATCH v2] cpu_pm: fix unmet dependency for CPU_PM
In-Reply-To: <alpine.LFD.2.11.1411170128560.11690@knanqh.ubzr>
References: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
 <alpine.LFD.2.11.1411170128560.11690@knanqh.ubzr>
Message-ID: <1978454.Vafaacm06c@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 17, 2014 01:29:20 AM Nicolas Pitre wrote:
> On Mon, 17 Nov 2014, Pankaj Dubey wrote:
> 
> > If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
> > we are getting following config warning.
> > 
> > warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
> > dependencies (SUSPEND || CPU_IDLE)
> > 
> > It has been noticed that CPU_PM dependencies in this file are not really
> > required so let's remove these dependencies from CPU_PM.
> > 
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Patch queued up for 3.19-rc1, thanks!

> > ---
> > This patch is second attempt to fix this config issue. Patch v1 and related
> > discussion can be found here [1]
> > 1: https://lkml.org/lkml/2014/11/14/673
> > 
> >  kernel/power/Kconfig |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index bbef57f..1eb7da7 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -308,4 +308,3 @@ config PM_GENERIC_DOMAINS_OF
> >  
> >  config CPU_PM
> >  	bool
> > -	depends on SUSPEND || CPU_IDLE
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
