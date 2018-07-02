From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 2 Jul 2018 00:53:50 +0000
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
Message-ID: <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, July 2, 2018 7:33 AM
> To: Shawn Guo <shawnguo@kernel.org>; Anson Huang
> <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; Mark Rutland
> <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>; Rob Herring <robh+dt@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> Fabio Estevam <fabio.estevam@nxp.com>; moderated list:ARM/FREESCALE
> IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
> 
> On Sun, Jul 1, 2018 at 6:34 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Mon, Jun 25, 2018 at 08:34:11PM +0800, Robin Gong wrote:
> >> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should be kept
> >> always on. But it's disabled after switch disabled interface
> >> implemented in pfuze driver 'commit 5fe156f1cab4
> >> ("regulator: pfuze100: add enable/disable for switch")'.Thus, it
> >> breaks kernel bootup. Add 'regulator-always-on' for SW4.
> >>
> >> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> >
> > Does that mean boards with existing DTB installed will stop working
> > with new kernel?  That's bad, and the kernel commit should probably be
> > reverted.
> 
> Yes, this is a good point.
> 
> Anson,
> 
> Should 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
> switch") be reverted to avoid such breakage?
 
Yes, I think we can revert it to avoid breakage. Didn't notice that some
i.MX platform do NOT have those critical switches always-on.

Anson.
