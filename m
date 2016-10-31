From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Mon, 31 Oct 2016 09:35:33 +0000
Subject: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <2723366.1bJeJ7SKI6@wuerfel>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-4-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
Message-ID: <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, October 28, 2016 6:53 PM
> To: linuxppc-dev at lists.ozlabs.org
> Cc: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Scott
> Wood; Mark Rutland; Greg Kroah-Hartman; X.B. Xie; M.H. Lian; linux-
> i2c at vger.kernel.org; linux-clk at vger.kernel.org; Qiang Zhao; Russell King;
> Bhupesh Sharma; Joerg Roedel; Claudiu Manoil; devicetree at vger.kernel.org;
> Rob Herring; Santosh Shilimkar; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Leo Li;
> iommu at lists.linux-foundation.org; Kumar Gala
> Subject: Re: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
> 
> On Friday, October 28, 2016 2:50:14 PM CEST Yangbo Lu wrote:
> > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > header file.  This SVR numberspace is used on some ARM chips as well
> > as PPC, and even to check for a PPC SVR multi-arch drivers would
> > otherwise need to ifdef the header inclusion and all references to the
> SVR symbols.
> >
> >
> 
> I don't see any of the contents of this header referenced by the soc
> driver any more. I think you can just drop this patch.
> 

[Lu Yangbo-B47093] This header file was included by guts.c.
The guts driver used macro SVR_MAJ/SVR_MIN for calculation.

This header file was for powerpc arch before. And this patch is to made it as common header file for both ARM and PPC.
Sooner or later this is needed.

> 	Arnd
