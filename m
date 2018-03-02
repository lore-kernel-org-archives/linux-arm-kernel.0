From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 2 Mar 2018 02:03:05 +0000
Subject: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
In-Reply-To: <20180301212253.fp4gxes57t2m2tg2@rob-hp-laptop>
References: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
 <1519859380-15878-2-git-send-email-Anson.Huang@nxp.com>
 <20180301212253.fp4gxes57t2m2tg2@rob-hp-laptop>
Message-ID: <AM3PR04MB1315478E79B0BFEF5A22DE80F5C50@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, March 2, 2018 5:23 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>; rui.zhang at intel.com;
> edubezval at gmail.com; mark.rutland at arm.com; shawnguo at kernel.org;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel at vger.kernel.org; linux-pm at vger.kernel.org
> Subject: Re: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> On Thu, Mar 01, 2018 at 07:09:40AM +0800, Anson Huang wrote:
> > This patch adds i.MX7 thermal sensor support, most of the i.MX7
> > thermal sensor functions are same with
> > i.MX6 except the registers offset/layout, so we move those registers
> > offset/layout definitions to soc data structure.
> >
> > i.MX7 uses single calibration data @25C, the calibration data is
> > located at OCOTP offset 0x4F0, bit[17:9], the formula is as below:
> >
> > Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> > changes since V4:
> > 	drop direct OCOTP register access for i.mx7d since it is a new added
> platform,
> > 	only support reading ocotp values through the ocotp nvmem driver which
> handles clock.
> >  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
> >  drivers/thermal/imx_thermal.c                      | 295
> ++++++++++++++++-----
> >  2 files changed, 239 insertions(+), 65 deletions(-)
> 
> Please add ack/reviewed-by's when posting new versions.
> 
> Rob
Sorry for missing it, I just sent out a V6 adding Reviewed-by, thanks.

Anson. 
