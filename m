From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Oct 2013 16:31:45 +0800
Subject: [PATCHv6][ 3/7] ARM: imx{25,27} DT: Permit the selection of the
 imxfb framebuffer driver.
In-Reply-To: <20131024102011.610e5d8b@e6520eb>
References: <1382601665-6830-1-git-send-email-denis@eukrea.com>
 <1382601665-6830-3-git-send-email-denis@eukrea.com>
 <20131024081531.GA13614@S2101-09.ap.freescale.net>
 <20131024102011.610e5d8b@e6520eb>
Message-ID: <20131024083143.GB13614@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:20:11AM +0200, Eric B?nard wrote:
> Hi Shawn,
> 
> Le Thu, 24 Oct 2013 16:15:34 +0800,
> Shawn Guo <shawn.guo@linaro.org> a ?crit :
> > >  config FB_IMX
> > >  	tristate "Freescale i.MX1/21/25/27 LCD support"
> > > -	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> > > +	depends on FB && HAVE_IMX_FB
> > 
> > Or simply have it depend on ARCH_MXC?
> > 
> > 	depends on FB && ARCH_MXC
> > 
> but not all MXC have IMX_FB : isn't that a problem ?

Is it really a problem that you see this option when you configure an
imx51 kernel?  The prompt clearly tells you do not need this option for
an imx51 kernel.  Or will it cause any real problem even if you select
it for an imx51 kernel, except you build in a driver which will never be
instantiated?  I've seen drivers even start drop ARCH_* dependency to
get a better randconfig build test coverage.

Shawn
