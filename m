From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 May 2017 11:18:02 +0800
Subject: [v2, 1/5] mmc: dt: add compatible into eSDHC required properties
In-Reply-To: <DB6PR0401MB2536CB3661070921AEA0C5B6F8EB0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
 <1493894940-47452-2-git-send-email-yangbo.lu@nxp.com>
 <20170505023651.GW18578@dragon>
 <DB6PR0401MB2536CB3661070921AEA0C5B6F8EB0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <20170505031801.GA852@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 03:01:04AM +0000, Y.B. Lu wrote:
> > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > index dedfb02..b04b248 100644
> > > --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> > > @@ -7,6 +7,7 @@ This file documents differences between the core
> > > properties described  by mmc.txt and the properties used by the sdhci-
> > esdhc driver.
> > >
> > >  Required properties:
> > > +  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
> > 
> > I think either supported <chip> or the compatible should be listed
> > explicitly.
> > 
> 
> [Lu Yangbo-B47093] I think the reason we use <chip> is to avoid listing too much chips, and to avoid doc updating if new chips are added.
> The checkpatch script also had considered that.
> 
> Currently there're about 20 platforms with "fsl,<chip>-esdhc" compatible in kernel dts.
> And the doc also provide an example.
> Example:
> 
> sdhci at 2e000 {
>         compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
> 
> Should we still need to list all ?

I anyway need an ACK from Rob on this patch.  Let's see what he would
say.

Shawn
