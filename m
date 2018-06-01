From: lsun@mellanox.com (Liming Sun)
Date: Fri, 1 Jun 2018 14:31:03 +0000
Subject: [PATCH v2 3/4] dt-bindings: soc: Add TmFifo binding for Mellanox
 BlueField SoC
In-Reply-To: <20180531034352.GA32666@rob-hp-laptop>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1527279436-14773-3-git-send-email-lsun@mellanox.com>
 <20180531034352.GA32666@rob-hp-laptop>
Message-ID: <AM2PR05MB0753BBB6F171CE94FCCAE046A1620@AM2PR05MB0753.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments. Please see response inline.

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, May 30, 2018 11:44 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; Arnd Bergmann <arnd@arndb.de>;
> David Woods <dwoods@mellanox.com>; Robin Murphy
> <robin.murphy@arm.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/4] dt-bindings: soc: Add TmFifo binding for
> Mellanox BlueField SoC
> 
> On Fri, May 25, 2018 at 04:17:15PM -0400, Liming Sun wrote:
> 
> Commit msg?

Updated in patch v3 3/4.

> 
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  .../devicetree/bindings/soc/mellanox/tmfifo.txt      | 20
> ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
> b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
> > new file mode 100644
> > index 0000000..0a362f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
> > @@ -0,0 +1,20 @@
> > +* Mellanox BlueField SoC TmFifo
> > +
> > +BlueField TmFifo provides a shared FIFO between the target and the
> > +external host machine, which can be accessed via USB or PCIe.
> 
> A FIFO for what? I'd like to find a better spot than bindings/soc/

This is a generic HW FIFO which can be accessed by the SoC SW and external Host machine to exchange any data. In the current Linux tmfifo driver, this FIFO has been used (demuxed) to implement a virtual console and network interface based on virtio framework.  

Updated the tmfifo.txt in patch v3 3/4 with the above explanation. Please advise if there is a better place for this file.
 
> > +
> > +Required properties:
> > +
> > +- compatible:	Should be "mellanox,bf-tmfifo"
> > +- reg:		Physical base address and length of Rx/Tx block
> > +- interrupts:	The interrupt number of Rx low water mark, Rx high water
> mark
> > +		Tx low water mark, Tx high water mark respectively.
> > +
> > +Example:
> > +
> > +tmfifo at 800a20 {
> > +	compatible = "mellanox,bf-tmfifo";
> > +	reg = <0x00800a20 0x00000018
> > +	       0x00800a40 0x00000018>;
> > +	interrupts = <41, 42, 43, 44>;
> > +};
> > --
> > 1.8.3.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
