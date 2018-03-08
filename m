From: martin@kaiser.cx (Martin Kaiser)
Date: Thu, 8 Mar 2018 16:38:32 +0100
Subject: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
In-Reply-To: <20180308161135.1f3d3d18@karo-electronics.de>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
 <20180308161135.1f3d3d18@karo-electronics.de>
Message-ID: <20180308153832.GA28454@botnar.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Thus wrote Lothar Wa?mann (LW at KARO-electronics.de):

> > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > index 9725705..cf70df2 100644
> > --- a/arch/arm/boot/dts/imx25.dtsi
> > +++ b/arch/arm/boot/dts/imx25.dtsi
> > @@ -269,6 +269,7 @@
> >  				dmas = <&sdma 24 1 0>,
> >  				       <&sdma 25 1 0>;
> >  				dma-names = "rx", "tx";
> > +				fsl,fifo-depth = <15>;
> >  				status = "disabled";
> >  			};

> > @@ -329,6 +330,7 @@
> >  				dmas = <&sdma 28 1 0>,
> >  				       <&sdma 29 1 0>;
> >  				dma-names = "rx", "tx";
> > +				fsl,fifo-depth = <15>;
> >  				status = "disabled";
> >  			};

> You are changing the global .dtsi file. Did you test this change with
> all devices that are affected by it?

I changed the hardware description of the imx25 SSI to match the
reference manual.

I did test this change on an imx25 board with audio playback. This uses
the SSI description I modified. I verified that the driver is actually
taking the modified setting into account and that this causes no
problems.

As of today, this setting is used by the fsl_ssi driver to set the fifo
water level for dma requests.

Of course, I don't have access to the enitre range of supported imx25
boards and I don't think this is required for submitting patches.

Do you have any indication why this patch should not be merged?

Best regards,
Martin
