From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Feb 2018 23:16:07 +0000
Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
In-Reply-To: <1519838731.16494.8.camel@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
 <1519838731.16494.8.camel@nxp.com>
Message-ID: <AM3PR04MB131547CE6052FAA9CC07CCADF5C70@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Leonard Crestez [mailto:leonard.crestez at nxp.com]
> Sent: Thursday, March 1, 2018 1:26 AM
> To: Anson Huang <anson.huang@nxp.com>; rui.zhang at intel.com;
> edubezval at gmail.com; shawnguo at kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-pm at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; robh+dt at kernel.org; Mark Rutland
> <mark.rutland@arm.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk; kernel at pengutronix.de; Lothar Wa?mann
> <LW@KARO-electronics.de>
> Subject: Re: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> On Sat, 2018-02-24 at 16:02 +0800, Anson Huang wrote:
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
> 
> On imx7d (also 6sx and 6ul) OCOTP read will hang silently if the ocotp clk is not
> enabled. For example this can happen if imx_thermal is built as a module or
> probes after unused clocks are disabled.
> 
> This driver has support for reading ocotp values through the ocotp nvmem
> driver (which handles clks properly). Since imx7d is a new compatible string for
> upstream maybe you could just make new-style bindings mandatory and drop
> the changes to?imx_init_from_tempmon_data?
> 
> See?commit 2067b757e972 ("ARM: dts: imx6ul: Add imx6ul-tempmon")


It makes sense, I sent out V5 to drop the direct OCOTP register access support, all OCOTP reading will
Be through ocotp nvmem driver on i.MX7D.

Anson.

> 
> --
> Regards,
> Leonard
