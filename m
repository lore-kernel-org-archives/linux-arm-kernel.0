From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 22:10:36 +0800
Subject: [PATCH v4 2/7] arm/imx6q: add core definitions and low-level
	debug uart
In-Reply-To: <20110929093245.GF23944@n2100.arm.linux.org.uk>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-3-git-send-email-shawn.guo@linaro.org>
	<20110929093245.GF23944@n2100.arm.linux.org.uk>
Message-ID: <20110929141035.GK19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:32:45AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 28, 2011 at 05:06:43PM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > index 502e45f..e2e3e5a 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -29,6 +29,13 @@ config ARCH_MX5
> >  	  This enables support for machines using Freescale's i.MX50 and i.MX51
> >  	  processors.
> >  
> > +config ARCH_MX6
> > +	bool "i.MX6"
> > +	select AUTO_ZRELADDR
> 
> This bars you from building a working kernel with ZBOOT_ROM=y.  You can
> still select ZBOOT_ROM=y but things won't work.
> 
Right.  This is going to be 'select AUTO_ZRELADDR if !ZBOOT_ROM'.

-- 
Regards,
Shawn
