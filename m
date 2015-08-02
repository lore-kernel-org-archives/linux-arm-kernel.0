From: Haibo.Chen@freescale.com (Chen Bough)
Date: Sun, 2 Aug 2015 09:02:21 +0000
Subject: [PATCH v3 4/6] mmc: sdhci-esdhc-imx: add compatible string in
 bingding doc
In-Reply-To: <20150731144354.GC27806@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-5-git-send-email-haibo.chen@freescale.com>
 <20150731144354.GC27806@shlinux1.ap.freescale.net>
Message-ID: <BY1PR03MB138864C76E6D8922405CA2359A880@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong at freescale.com]
> Sent: Friday, July 31, 2015 10:44 PM
> To: Chen Haibo-B51421
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; shawnguo at kernel.org;
> kernel at pengutronix.de; linux at arm.linux.org.uk; ulf.hansson at linaro.org;
> johan.derycke at barco.com; Estevam Fabio-R49496; Dong Aisheng-B29396;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-mmc at vger.kernel.org
> Subject: Re: [PATCH v3 4/6] mmc: sdhci-esdhc-imx: add compatible string
> in bingding doc
> 
> On Wed, Jul 29, 2015 at 05:03:55PM +0800, Haibo Chen wrote:
> > Add a required property "fsl,imx7d-usdhc" in binding doc.
> > Add an optional property "fsl,tuning-step" in binding doc.
> >
> 
> Better change to:
> mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
> 
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > index 211e778..c6624bc 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >  	       "fsl,imx6q-usdhc"
> >  	       "fsl,imx6sl-usdhc"
> >  	       "fsl,imx6sx-usdhc"
> > +	       "fsl,imx7d-usdhc"
> >
> >  Optional properties:
> >  - fsl,wp-controller : Indicate to use controller internal write
> > protection @@ -27,6 +28,7 @@ Optional properties:
> >    transparent level shifters on the outputs of the controller. Two
> cells are
> >    required, first cell specifies minimum slot voltage (mV), second
> cell
> >    specifies maximum slot voltage (mV). Several ranges could be
> specified.
> > +- fsl,tuning-step: Specify the increasing delay cell steps in tuning
> procedure.
> 
> we could add more explain about this property for better understanding:
> e.g. The uSDHC is using one delay cell as default increasing step to do
> tuning process. This property allows user to change the tuning step to
> more than one delay cells which is useful for some special boards or
> cards when the default tuning step can't find the proper delay window
> within limited tuning reties.

[haibo] for imx7d, seems this is soc related. But here, yes, I should do more explain.
 
> 
> >
> >  Examples:
> >
> > --
> > 1.9.1
> >
> 
> Regards
> Dong Aisheng
