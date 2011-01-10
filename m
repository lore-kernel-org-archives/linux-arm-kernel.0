From: nbowler@elliptictech.com (Nick Bowler)
Date: Mon, 10 Jan 2011 16:16:22 -0500
Subject: [PATCH] ARM: vexpress: register platform PATA device.
In-Reply-To: <20110107224348.GZ31708@n2100.arm.linux.org.uk>
References: <1294435445-2020-1-git-send-email-nbowler@elliptictech.com>
	<20110107224348.GZ31708@n2100.arm.linux.org.uk>
Message-ID: <20110110211622.GA10381@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-01-07 22:43 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 07, 2011 at 04:24:05PM -0500, Nick Bowler wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d56d21c..ee61039 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -264,6 +264,7 @@ config ARCH_VEXPRESS
> >  	select HAVE_CLK
> >  	select ICST
> >  	select PLAT_VERSATILE
> > +	select HAVE_PATA_PLATFORM
> 
> To avoid the Kconfig warning, this should be:
> 
> 	select HAVE_PATA_PLATFORM if ATA
> 
> or it needs to be moved outside of the if ATA ... endif block in
> drivers/ata/Kconfig.

The Kconfig dependency fix was merged into mainline today, so this patch
should no longer trigger the aforementioned warning.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
