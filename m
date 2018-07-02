From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 2 Jul 2018 00:55:41 +0000
Subject: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
In-Reply-To: <20180701133243.GU4348@dragon>
References: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
 <20180701133243.GU4348@dragon>
Message-ID: <AM3PR04MB1315C55572F4A1B1581CC5B4F5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Sunday, July 1, 2018 9:33 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> devicetree at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
> 
> On Wed, Jun 27, 2018 at 09:25:25AM +0800, Anson Huang wrote:
> > On i.MX6SLL EVK board, PFuze100's SW4 is supplying LPDDR3, it needs to
> > be always on. This patch fixes Linux kernel boot up hang caused by
> > commit 5fe156f1cab4
> > ("regulator: pfuze100: add enable/disable for switch"), because SW4 is
> > turned off unexpectedly:
> >
> > [    1.693613] cfg80211: failed to load regulatory.db
> > [    1.700063] SW4: disabling
> > [    1.703973] SWBST: disabling
> >
> > Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
> > switch")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Just want to understand if we agree to break the existing DTB with v4.18
> kernel?
> 
> Shawn

The kernel patch will break with existing DTB on some i.MX platforms, how
to handle this case, just revert the kernel regulator patch? 

Anson.

> 
> > ---
> > changes since V2:
> > 	improve the way of referencing commit, and add fix tag.
> >  arch/arm/boot/dts/imx6sll-evk.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sll-evk.dts
> > b/arch/arm/boot/dts/imx6sll-evk.dts
> > index 4684ac4..2217c40 100644
> > --- a/arch/arm/boot/dts/imx6sll-evk.dts
> > +++ b/arch/arm/boot/dts/imx6sll-evk.dts
> > @@ -142,6 +142,7 @@
> >  			sw4_reg: sw4 {
> >  				regulator-min-microvolt = <800000>;
> >  				regulator-max-microvolt = <3300000>;
> > +				regulator-always-on;
> >  			};
> >
> >  			swbst_reg: swbst {
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%7
> >
> CAnson.Huang%40nxp.com%7C614a104918884539521a08d5df572851%7C686
> ea1d3bc
> >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C636660487794141749&sdata=1%2B
> EKM%2Bnx
> > egyDGLc%2FHt9cbh%2BARlMSsoJP%2FbD6HlxwVFs%3D&reserved=0
