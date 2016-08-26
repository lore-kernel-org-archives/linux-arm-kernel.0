From: anson.huang@nxp.com (Yongcai Huang)
Date: Fri, 26 Aug 2016 13:02:12 +0000
Subject: [PATCH 0/3] Add SMP support for i.MX7D
In-Reply-To: <CAOMZO5DaL+CKQe0hOHi_Kv8Vt9y0RHyERS8ek78WebxFmjj9rg@mail.gmail.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DaL+CKQe0hOHi_Kv8Vt9y0RHyERS8ek78WebxFmjj9rg@mail.gmail.com>
Message-ID: <AM3PR04MB13159C5A59AA393F082C2445F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2016-08-26 8:43 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel <linux-kernel@vger.kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> robh+dt at kernel.org; Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> Subject: Re: [PATCH 0/3] Add SMP support for i.MX7D
> 
> Hi Anson,
> 
> On Fri, Aug 26, 2016 at 8:12 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> > i.MX7D has 2 Cortex-A7 ARM cores, and it has a different GPC design
> > than i.MX6, so this patch set adds a new GPCV2 driver for i.MX7D, and
> > also adds runtime check in SMP code to support both Cortex-A9 and
> > Cortex-A7 ARM cores.
> >
> > With this patch set, i.MX7D can boot up SMP kernel with 2 CPUs.
> 
> Currently mx7d can boot the 2 CPUs if you use PSCI in the bootloader.
> 
> Give mainline U-Boot a try and it will boot the 2 CPUs via PSCI.
> 
> There was an attempt to add gpcv2 support at:
> https://patchwork.kernel.org/patch/6919831/
> 
> , and Shawn suggested to go to the PSCI approach.
> 
> PSCI for mx7 is still missing suspend support though.
> 
> Regards,
> 
> Fabio Estevam

Thanks Fabio for the info, OK, now that i.MX7D goes with PSCI, then please
Ignore this patch set, and I will add suspend support later. Please ignore this
Patch set.

For the suggestion of replace cpu_is_xxx with soc_is_xxx by Russell King, I will
Send another patch to improve that.

Anson.
