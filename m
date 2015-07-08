From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Thu, 9 Jul 2015 00:31:56 +0200
Subject: [PATCH v6 4/6] ARM: vf610: enable NAND Flash Controller
In-Reply-To: <BLU436-SMTP255283C042EDEF59D9BA0CFB8910@phx.gbl>
References: <1434668319-6651-1-git-send-email-stefan@agner.ch>
 <1434668319-6651-5-git-send-email-stefan@agner.ch>
 <20150708093801.GG28488@tiger>
 <BLU436-SMTP255283C042EDEF59D9BA0CFB8910@phx.gbl>
Message-ID: <20150708223156.GA3103@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 10:32:54AM -0400, Bill Pringlemeir wrote:
> >> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> >> index 3a3d3e9..9358135 100644
> >> --- a/arch/arm/mach-imx/Kconfig
> >> +++ b/arch/arm/mach-imx/Kconfig
> >>>> -589,6 +589,7 @@ config SOC_VF610
> >> 	select PINCTRL_VF610
> >> 	select PL310_ERRATA_769419 if CACHE_L2X0
> >> 	select SMP_ON_UP if SMP
> >> +	select HAVE_NAND_VF610_NFC
> 
> > I'm not sure about the benefit of having this option, except we have
> > to have this additional architecture patch.
> 
> For other SOC, like the PowerPC or ColdFire CPUs with this controller,
> it was a way to mark the controller as populated.  Otherwise, the
> Kconfig entry to select the controller will pop up for everybody.
> 
> Is there a better way to do this?

use
	depends on SOC_VF610
instead.

Sebastian
