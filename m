From: alison.wang@nxp.com (Alison Wang)
Date: Mon, 13 Feb 2017 07:39:41 +0000
Subject: [PATCH v3 1/2] mtd: ifc: Update dependency of IFC for LS1021A
In-Reply-To: <20170213083401.5adf8c31@bbrezillon>
References: <1486968416-13536-1-git-send-email-b18965@freescale.com>
 <20170213083401.5adf8c31@bbrezillon>
Message-ID: <DB6PR0401MB258411171005499F70EAE505F4590@DB6PR0401MB2584.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Boris,

	Sorry, I forgot to change them. Should I resend them or you help to fix that when applying?


Best Regards,
Alison Wang

> 
> Hi Alison,
> 
> The subject prefix is still wrong, should be 'memory: ifc: '.
> 
> On Mon, 13 Feb 2017 14:46:55 +0800
> Alison Wang <b18965@freescale.com> wrote:
> 
> > As Freescale/NXP IFC controller is available on LS1021A, the
> > dependency for LS1021A is added.
> >
> > LS1021A is an earlier product and is not compatible with later
> > LayerScape architecture. So ARCH_LAYERSCAPE can't cover LS1021A.
> >
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > ---
> > Changes in v3:
> > - Update the commit message.
> >
> > Changes in v2:
> > - New patch
> >
> >  drivers/memory/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig index
> > ec80e35..fff8345 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -115,7 +115,7 @@ config FSL_CORENET_CF
> >
> >  config FSL_IFC
> >  	bool
> > -	depends on FSL_SOC || ARCH_LAYERSCAPE
> > +	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
> >
> >  config JZ4780_NEMC
> >  	bool "Ingenic JZ4780 SoC NEMC driver"
