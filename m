From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 28 Jun 2016 12:40:02 +0300
Subject: [PATCH] ARM: oxnas: Change OX810SE default driver config
In-Reply-To: <577237F4.8080707@baylibre.com>
References: <1465987517-24482-1-git-send-email-narmstrong@baylibre.com>
 <577237F4.8080707@baylibre.com>
Message-ID: <20160628094002.GA2565@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Tue, Jun 28, 2016 at 10:40:20AM +0200, Neil Armstrong wrote:
> On 06/15/2016 12:45 PM, Neil Armstrong wrote:
> > Since the SP804 timer changes will not been merged upstream, switch the
> > default OX810SE config to the OXNAS RPS Timer driver configuration.
> > 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  arch/arm/mach-oxnas/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Dear arm-soc maintainers,
> > 
> > Daniel just accepted my patchset at :
> > http://lkml.kernel.org/r/1465985607-21231-1-git-send-email-narmstrong at baylibre.com
> > 
> > And now the default config can be switched to OXNAS_RPS_TIMER without any
> > device tree changes.
> 
> Gentle ping about this patch, it would be great to see it in 4.8 !

To get the attention of arm-soc maintainers make sure to have arm at kernel.org 
in your recipients list.

baruch

> > diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
> > index 4fff3c7..ffcab02 100644
> > --- a/arch/arm/mach-oxnas/Kconfig
> > +++ b/arch/arm/mach-oxnas/Kconfig
> > @@ -11,7 +11,7 @@ if ARCH_OXNAS
> >  
> >  config MACH_OX810SE
> >  	bool "Support OX810SE Based Products"
> > -	select ARM_TIMER_SP804
> > +	select OXNAS_RPS_TIMER
> >  	select COMMON_CLK_OXNAS
> >  	select CPU_ARM926T
> >  	select MFD_SYSCON

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
