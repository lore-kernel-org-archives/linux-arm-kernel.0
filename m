From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Tue, 8 Nov 2016 06:49:51 +0000
Subject: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <1543282.vWjeo4ynTa@wuerfel>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
 <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <1543282.vWjeo4ynTa@wuerfel>
Message-ID: <DB6PR0401MB25366BC8FF59C68E2823245EF8A60@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, November 08, 2016 5:20 AM
> To: Y.B. Lu
> Cc: linuxppc-dev at lists.ozlabs.org; linux-mmc at vger.kernel.org;
> ulf.hansson at linaro.org; Scott Wood; Mark Rutland; Greg Kroah-Hartman; X.B.
> Xie; M.H. Lian; linux-i2c at vger.kernel.org; linux-clk at vger.kernel.org;
> Qiang Zhao; Russell King; Bhupesh Sharma; Joerg Roedel; Claudiu Manoil;
> devicetree at vger.kernel.org; Rob Herring; Santosh Shilimkar; linux-arm-
> kernel at lists.infradead.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Leo Li; iommu at lists.linux-foundation.org; Kumar
> Gala
> Subject: Re: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
> 
> On Monday, October 31, 2016 9:35:33 AM CET Y.B. Lu wrote:
> > >
> > > I don't see any of the contents of this header referenced by the soc
> > > driver any more. I think you can just drop this patch.
> > >
> >
> > [Lu Yangbo-B47093] This header file was included by guts.c.
> > The guts driver used macro SVR_MAJ/SVR_MIN for calculation.
> >
> > This header file was for powerpc arch before. And this patch is to
> > made it as common header file for both ARM and PPC.
> > Sooner or later this is needed.
> 
> Let's discuss it once we actually need the header then, ok?

[Lu Yangbo-B47093] As I said, this header file was included by guts.c in patch 4.
The guts driver used macro SVR_MAJ/SVR_MIN for calculation which were defined in this header file.
Did you suggest we dropped this patch and just calculated them in driver?

Thanks :)


> 
> 	Arnd
