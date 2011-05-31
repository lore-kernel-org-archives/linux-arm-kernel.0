From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 31 May 2011 23:10:20 +0800
Subject: [PATCH 2/4] ARM: mxc: migrate mach-mx5 gpio driver to gpio-mxc
In-Reply-To: <201105311328.18012.arnd@arndb.de>
References: <1306767139-24763-1-git-send-email-shawn.guo@linaro.org>
	<201105311026.11947.arnd@arndb.de>
	<20110531103011.GB32096@S2100-06.ap.freescale.net>
	<201105311328.18012.arnd@arndb.de>
Message-ID: <20110531151019.GA32275@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 01:28:17PM +0200, Arnd Bergmann wrote:
> On Tuesday 31 May 2011, Shawn Guo wrote:
> > > Just open-code the mxc_add_mxc_gpio() by moving the individual calls to
> > > mxc_add_gpio() into the respective callers. Having a global
> > > mxc_add_mxc_gpio() function that does something different for each
> > > caller seems entirely pointless to me.
> > > 
> > Right now, mxc_add_mxc_gpio() is a postcore_initcall.  Moving
> > individual mxc_add_gpio() call into irq_init function does not work.
> > And I need to find a proper caller for each SoC to call mxc_add_gpio
> > to register gpio devices.
>  
> Why not init_machine? That is an arch_initcall(), so it's probably close
> enough.
> 
The init_machine is mostly a board specific function than SoC specific
one.  That is to say we will call mxc_add_gpio() in every single board
init function even for the same SoC.

-- 
Regards,
Shawn
