From: frank.li@nxp.com (Frank Li)
Date: Thu, 18 Feb 2016 16:56:22 +0000
Subject: iMX7d cpu1 issue
In-Reply-To: <56C5F4D7.1070704@compulab.co.il>
References: <56C2D63F.1030408@compulab.co.il> <20160218140913.GY6756@tiger>
 <AMSPR04MB263D00A3F8D9A8D9D3A536D88AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <56C5F4D7.1070704@compulab.co.il>
Message-ID: <AMSPR04MB26334EB884FA8A4B565278188AF0@AMSPR04MB263.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Ilya Ledvich [mailto:ilya at compulab.co.il]
> Sent: Thursday, February 18, 2016 10:44 AM
> To: Frank Li <frank.li@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org; Yongcai Huang
> <anson.huang@nxp.com>
> Subject: Re: iMX7d cpu1 issue
> 
> Hi!
> 
> On 02/18/2016 05:24 PM, Frank Li wrote:
> >
> >
> >> -----Original Message-----
> >> From: Shawn Guo [mailto:shawnguo at kernel.org]
> >> Sent: Thursday, February 18, 2016 8:09 AM
> >> To: Ilya Ledvich <ilya@compulab.co.il>
> >> Cc: linux-arm-kernel at lists.infradead.org; Frank Li
> >> <frank.li@nxp.com>; Yongcai Huang <anson.huang@nxp.com>
> >> Subject: Re: iMX7d cpu1 issue
> >>
> >> On Tue, Feb 16, 2016 at 09:56:47AM +0200, Ilya Ledvich wrote:
> >>> Hi Shawn,
> >>> I'm working on Compulab CL-SOM-IMX7 device
> >>> (http://www.compulab.co.il/products/computer-on-modules/cl-som-
> >> imx7-fr
> >>> eescale-i-mx-7-system-on-module)
> >>> based on Freescale iMX7d CPU.
> >>> I use the Freescale latest BSP imx_3.14.52_1.1.0_ga  and the Linux
> >>> mainline v4.4-rc6 as a reference.
> >>> I observe an issue with bringing up the second CPU core. Briefly,
> >>> the kernel can successfully boot only when CPU1 fails to come online.
> >>> In this case the boot log shows the following messages:
> >>> ...
> >>> CPU1: failed to come online
> >>> Brought up 1 CPUs
> >>> SMP: Total of 1 processors activated (6.00 BogoMIPS).
> >>> ...
> >>>
> >>> Otherwise, the device tries to start kernel several times until the
> >>> boot process eventually crashes. Please see attached logs for more
> >>> details.
> >>> This never happens on mainline Linus kernel, because it never tries
> >>> to bring up CPU1.
> >>> Unfortunately, we cannot verify this behavior on reference board
> >>> cause we have no one.
> >>> Have you ever seen such behavior? Could you please advice something?
> >
> > Did you set arm,cpu-registers-not-fw-configured; in arch timer?
> 
> Yes, it's set in the imx7d.dtsi file included by my device .dts.
> 
> > How about your uboot version?
> >
> > Latest upstream uboot already boot A7 as no-security mode.
> 
> I actually use v2016.01 from the upstream and u-boot sources are based on
> on mx7dsabresd.c.

Can you try to disable NOSEC?

#define CONFIG_MX7_SEC

include/configs/mx7_common.h

Best regards
Frank Li

> 
> >
> > Best regards
> > Frank Li
> >
> 
> Kind regards,
> Ilya.
