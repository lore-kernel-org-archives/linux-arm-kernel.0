From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 12:51:01 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419194323.GP10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
 <517173C0.6010902@ti.com> <20130419194323.GP10155@atomide.com>
Message-ID: <20130419195100.GR10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130419 12:49]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130419 09:46]:
> > On 2013-04-19 19:12, Tony Lindgren wrote:
> > > * Rob Herring <robherring2@gmail.com> [130418 20:11]:
> > 
> > >> dss-common.c:(.cpuinit.text+0x38): undefined reference to `omap_get_wakeupgen_base'
> > >> dss-common.c:(.cpuinit.text+0x48): undefined reference to `omap_secure_apis_support'
> > >> dss-common.c:(.init.text+0x3db0): undefined reference to `omap_get_wakeupgen_base'
> > >> dss-common.c:(.init.text+0x3dcc): undefined reference to `omap_secure_apis_support'
> > >> dss-common.c:(.init.text+0x61b8): undefined reference to `usb_bind_phy'
> > >> dss-common.c:(.init.text+0x6314): undefined reference to `usb_bind_phy'
> > >> dss-common.c:(.init.text+0x6488): undefined reference to `usb_bind_phy'
> > >> dss-common.c:(.init.text+0x65ac): undefined reference to `usb_bind_phy'
> > >> dss-common.c:(.ref.text+0x10): undefined reference to `omap_get_wakeupgen_base'
> > >> dss-common.c:(.ref.text+0x18): undefined reference to `omap_secure_apis_support'
> > >> dss-common.c:(.ref.text+0x54): undefined reference to `omap4_hotplug_cpu'
> > >> dss-common.c:(.ref.text+0x58): undefined reference to `omap_secure_apis_support'
> > >> dss-common.c:(.text+0x11b5c): undefined reference to `usb_bind_phy'
> > > 
> > > Tomi, can you take a look at the dss-common.c one? That should be
> > > reproducable with omap2plus_defconfig and modifying some options
> > > there.
> > 
> > None of those functions are used by dss-common.c, so I don't really know
> > what that is about. Doesn't look correct errors to me... I can try to
> > reproduce.
> 
> This might happen when no SoC selected. There was a patch posted
> by Arnd to always select 2420 if nothing else is selected as it's the
> most minimal one. But Russell did not like that, so probably the way
> to fix that would be to have bool OMAP_SOC and if not selected, don't
> even try to build anything. I'll take a look at that.
> 
> > Btw, there's also this:
> > 
> > >> drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
> > >> drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]
> > >> drivers/video/omap2/dss/dpi.c:212:2: error: implicit declaration of function 'dsi_pll_calc' [-Werror=implicit-function-declaration]
> > 
> > I have a patch for that, not yet applied.
> 
> OK thanks.

Sorry forgot to leave out my .config in the previous mail. No need for
the .config I posted as you already have those errors fixed.

Regards,

Tony 
