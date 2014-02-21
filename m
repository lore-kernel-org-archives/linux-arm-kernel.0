From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Feb 2014 12:38:31 +0000
Subject: [PATCH v10 01/15] usb: doc: phy-mxs: Add more compatible strings
In-Reply-To: <5e4d795b507a4ea7b9faa69dd05148c4@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
 <1392873284-9386-2-git-send-email-peter.chen@freescale.com>
 <20140221091345.GA7541@e106331-lin.cambridge.arm.com>
 <5e4d795b507a4ea7b9faa69dd05148c4@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <20140221123831.GG8783@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 09:40:29AM +0000, Peter Chen wrote:
>  
> > >
> > >  Required properties:
> > > -- compatible: Should be "fsl,imx23-usbphy"
> > > +- compatible: "fsl,imx23-usbphy" for imx23 and imx28, "fsl,imx6q-
> > usbphy"
> > > +  for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
> > 
> > Minor nit, but could we restructure this as something like the following,
> > with each string on a new line:
> > 
> > - compatible: should contain:
> >     * "fsl,imx23-usbphy" for imx23 and imx28
> >     * "fsl,imx6q-usbphy" for imx6dq and imx6dl
> >     * "fsl,imx6sl-usbphy" for imx6sl
> > 
> > It makes it a bit easier to read.
> 
> Thanks, will change like above.
> 
> > 
> > I see the existing "fsl,imx23-usbphy" is used as a fallback for
> > "fsl,imx28-usbphy", "fsl,imx6q-usbphy", and "fsl,imx6sl-usbphy" in
> > existing DTs.
> > 
> > Is this expected going forward? It might be worth mentioning.
> > 
> 
> These SoCs used the same FSL imx PHY, but different versions.
> imx23/imx28 are the first version, more improvements are at
> later SoCs (like imx6x) version. Keep "fsl,imx23-usbphy" at
> imx6 dts will be user know it is from imx23's. If you think
> it does not need, I can delete "fsl,imx23-usbphy" from imx6 dts.

I'm not arguing to remove it, I'm suggesting it might be worth
mentioning that it's not mutually exclusive, and can be a fallback for
the other strings.

Cheers,
Mark.
