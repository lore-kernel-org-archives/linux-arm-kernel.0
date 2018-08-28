From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 28 Aug 2018 00:08:20 -0700
Subject: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
 other i.MX platforms
In-Reply-To: <DB3PR0402MB3916B5A489F6CD0B679C273AF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
 <1533537589-7202-2-git-send-email-Anson.Huang@nxp.com>
 <CAHQ1cqGA37RNoo3KcESCOFeYZxAQCOFkuQQhRPRKCTp=gKLdKQ@mail.gmail.com>
 <CAHQ1cqEy0hQg3ByZVx4tW7f6cifzU++ptrV40TcH01GsKmHP3g@mail.gmail.com>
 <DB3PR0402MB3916B5A489F6CD0B679C273AF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <CAHQ1cqGAywG=fm1YzfC=iJ+YpxfUn+i7jiPUeiRpyya28Mkq-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 7:32 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Andrey
>
> Anson Huang
> Best Regards!
>
>
> > -----Original Message-----
> > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Sent: Tuesday, August 28, 2018 7:04 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <fabio.estevam@nxp.com>; linux-arm-kernel
> > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
> > other i.MX platforms
> >
> > On Mon, Aug 27, 2018 at 3:51 PM Andrey Smirnov
> > <andrew.smirnov@gmail.com> wrote:
> > >
> > > On Sun, Aug 5, 2018 at 11:45 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > > >
> > > > i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they can
> > > > reuse gpcv2 pgc driver for power domain control, this patch renames
> > > > all functions and structure definitions started with "imx7" to
> > > > "imx", and check machine type to pass platform specific power domain
> > > > data for power domain driver, thus make
> > > > gpcv2 pgc driver more generic for i.MX platforms.
> > > >
> > >
> > > Just for the sake of
> >
> > Oops, forgot to type out the question I had about i.MX8MQ GPC in general. I've
> > noticed that vendor tree for i.MX8MQ has a separate driver for GPC that relies
> > on code in ARM Trusted Firmware binary blob to do the actual switching. Do
> > you by any chances know the relation between this code and the driver I
> > describe? Are they mutually exclusive or complimentary (I assume the former)?
> > Will the ATF-based driver be eventually deprecated?
>
> Yes, our internal NXP tree currently put all GPC registers operation in ARM Trusted Firmware, and
> Linux kernel has a gpc-psci.c which is a virtual GPC driver to call SMC and trap into ARM Trusted Firmware
> whenever it wants to read/write GPC registers. But for upstream, we plan to reuse i.MX7D's
> GPC driver for power domain control, since the GPC registers for power domain control are
> independent with other low power mode's control registers, it is NOT necessary to introduce
> another virtual GPC driver to call ARM Trusted Firmware for power domain control.
>
> So yes, ATF-based gpc driver for power domain control will be deprecated when we upstream the ATF for
> i.MX8MQ series SoCs. We prefer to reuse the i.MX7D's GPC driver in upstream Linux kernel. If you are OK
> with this, I will send out a V2 patch set to address your comments, thanks.

By all means, I have no objections, the more this code can be reused
the better. I just wanted to confirm if I understood the relation
between two drivers and their future right, that's all.

Thanks,
Andrey Smirnov
