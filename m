From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Thu, 9 Apr 2015 15:41:51 +0000
Subject: [PATCH 1/2] doc/bindings: Add 'endianess' optional-property for
 FlexCAN controller
In-Reply-To: <5526939C.5090309@pengutronix.de>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
 <5526939C.5090309@pengutronix.de>
Message-ID: <BY1PR0301MB1303675949A61BA1034DC16282FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> 
> On 04/09/2015 04:51 PM, Bhupesh Sharma wrote:
> > This patch adds 'endianess' as the optional-property for describing
> > the FlexCAN controller present on various FSL platforms.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> > ---
> >  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > index 56d6cc3..0d5e668 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > @@ -18,6 +18,10 @@ Optional properties:
> >
> >  - xceiver-supply: Regulator that powers the CAN transceiver
> >
> > +- little-endian: If the FlexCAN IP on this SoC is little-endian, use
> > +                 this property. By default it is assumed that the IP
> > +                 is big-endian
> 
> Where's the code that's evaluating this property? On ARM little endian is
> assumed so far, on powerpc (p1010) it's big endian.
> 

Here: http://thread.gmane.org/gmane.linux.can/7961

On LS1021A SoC, which is an ARM-v7 based SoC, the FlexCAN IP is big-endian.

Regards,
Bhupesh
