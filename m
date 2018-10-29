From: poonam.aggrwal@nxp.com (Poonam Aggrwal)
Date: Mon, 29 Oct 2018 11:09:24 +0000
Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
In-Reply-To: <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
 <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <VI1PR04MB4976D4A33E0561D125BE837486F30@VI1PR04MB4976.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Vabhav Sharma
> Sent: Monday, October 29, 2018 2:28 PM
> To: sudeep.holla at arm.com; oss at buserror.net; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> mturquette at baylibre.com; sboyd at kernel.org; rjw at rjwysocki.net;
> viresh.kumar at linaro.org; linux-clk at vger.kernel.org; linux-pm at vger.kernel.org;
> linux-kernel-owner at vger.kernel.org; catalin.marinas at arm.com;
> will.deacon at arm.com; gregkh at linuxfoundation.org; arnd at arndb.de;
> kstewart at linuxfoundation.org; yamada.masahiro at socionext.com; Leo Li
> <leoyang.li@nxp.com>; shawnguo at kernel.org
> Cc: ulf.hansson at linaro.org; Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansal
> <pankaj.bansal@nxp.com>; linux at armlinux.org.uk; adrian.hunter at intel.com;
> Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma <vabhav.sharma@nxp.com>;
> Yinbo Zhu <yinbo.zhu@nxp.com>
> Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
> 
> Adding compatible string "lx2160a-dcfg" to initialize guts driver for lx2160 and
> SoC die attribute definition for LX2160A
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
> 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>  	  .svr		= 0x87000000,
>  	  .mask		= 0xfff70000,
>  	},
> +	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +	{ .die          = "LX2160A",
> +	  .svr          = 0x87360000,
Do all  the threevariants " LX2160A/LX2120A/LX2080A"  have same SVR?
> +	  .mask         = 0xff3f0000,
> +	},
>  	{ },
>  };
> 
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>  	{ .compatible = "fsl,ls1088a-dcfg", },
>  	{ .compatible = "fsl,ls1012a-dcfg", },
>  	{ .compatible = "fsl,ls1046a-dcfg", },
> +	{ .compatible = "fsl,lx2160a-dcfg", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=02%7C01%7Cpoonam.aggrwal%40nxp.com%7Cd9b7c36c786
> 54cd6dc4008d63d7fee63%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636764017001504288&amp;sdata=pqFMlw6yVrHrvn4YRhqj%2FmoOnSscrZu
> tcoYn3In8OJc%3D&amp;reserved=0
