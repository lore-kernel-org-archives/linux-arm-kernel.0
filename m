From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Mar 2015 10:42:09 +0100
Subject: [PATCH] ARM: at91: force CPU selection
In-Reply-To: <2216832.iXiqHye8YX@wuerfel>
References: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
 <2216832.iXiqHye8YX@wuerfel>
Message-ID: <20150310094209.GD9188@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2015 at 10:02:15 +0100, Arnd Bergmann wrote :
> On Monday 09 March 2015 23:59:58 Brian Norris wrote:
> > @@ -114,6 +114,12 @@ config SOC_AT91SAM9
> >             AT91SAM9XE
> >  endif # SOC_SAM_V4_V5
> >  
> > +config MACH_AT91_AUTO
> > +       def_bool y
> > +       depends on !SOC_AT91SAM9 && !SOC_SAMA5D4
> > +       select SOC_SAMA5D3 if SOC_SAM_V7
> > +       select SOC_AT91RM9200 if SOC_SAM_V4_V5
> > +
> >  comment "AT91 Feature Selections"
> >  
> >  config AT91_SLOW_CLOCK
> 
> Hi Brian,
> 
> I actually added a bunch of these in other places, but have stopped
> doing so because Russell didn't like them, and I tend to follow
> his argument now that it's actually pretty confusing.
> 
> In case of at91, we can do better now, once we have multiplatform
> enabled, and we can simply remove the SOC_SAM_V7 and SOC_SAM_V4_V5
> symbols entirely (if Alexandre's patch doesn't already do that).
> 

I didn't remove it to keep the sub menus SOC_SAM_V7 -> SOC_SAMA5D4 and
SOC_SAMA5D3, SOC_SAM_V4_V5 -> SOC_AT91SAM9 and SOC_AT91RM9200. But I can
also expose SOC_AT91RM9200, SOC_AT91SAM9, SOC_SAMA5D3 and SOC_SAMA5D4
instead of SOC_SAM_V7 and SOC_SAM_V4_V5 and remove them.

> With multiplatform enabled, you no longer have to select a particular
> SoC, because we always get the default selection and the kernel
> will build without any one of them being enabled.
> 

Indeed, with multiplatform, the kernel will compile without any of those
being selected.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
