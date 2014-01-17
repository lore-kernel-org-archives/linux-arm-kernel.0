From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 17 Jan 2014 02:22:26 +0000
Subject: [PATCHv9 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <201401161202.49333.arnd@arndb.de>
References: <1389839400-29728-1-git-send-email-b35083@freescale.com>
 <1389839400-29728-3-git-send-email-b35083@freescale.com>
 <201401161202.49333.arnd@arndb.de>
Message-ID: <8e515b3695ea4c33a61f354b77be0b6b@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, January 16, 2014 7:03 PM
> To: Lu Jingchang-B35083
> Cc: vinod.koul at intel.com; dan.j.williams at intel.com; shawn.guo at linaro.org;
> pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Wang Huan-B18965
> Subject: Re: [PATCHv9 2/2] dma: Add Freescale eDMA engine driver support
> 
> On Thursday 16 January 2014, Jingchang Lu wrote:
> > Add Freescale enhanced direct memory(eDMA) controller support.
> > This module can be found on Vybrid and LS-1 SoCs.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> 
> Very nice! All my previous comments have been addressed, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> One small comment still:
> 
> > +
> > +static DEFINE_MUTEX(fsl_edma_mutex);
> > +
> 
> I think this mutex should be part of struct fsl_edma_engine, not global.
Yes, it should be for each edma controller, I will define it in struct fsl_edma_engine. Thanks.


Best Regards,
Jingchang
