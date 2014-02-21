From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 21 Feb 2014 17:05:46 +0800
Subject: [PATCH v10 01/15] usb: doc: phy-mxs: Add more compatible strings
In-Reply-To: <53072081.2000407@pengutronix.de>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
 <1392873284-9386-2-git-send-email-peter.chen@freescale.com>
 <20140221091345.GA7541@e106331-lin.cambridge.arm.com>
 <5e4d795b507a4ea7b9faa69dd05148c4@BL2PR03MB226.namprd03.prod.outlook.com>
 <53072081.2000407@pengutronix.de>
Message-ID: <20140221090544.GC13483@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 10:46:41AM +0100, Marc Kleine-Budde wrote:
> On 02/21/2014 10:40 AM, Peter Chen wrote:
> >  
> >>>
> >>>  Required properties:
> >>> -- compatible: Should be "fsl,imx23-usbphy"
> >>> +- compatible: "fsl,imx23-usbphy" for imx23 and imx28, "fsl,imx6q-
> >> usbphy"
> >>> +  for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
> >>
> >> Minor nit, but could we restructure this as something like the following,
> >> with each string on a new line:
> >>
> >> - compatible: should contain:
> >>     * "fsl,imx23-usbphy" for imx23 and imx28
> >>     * "fsl,imx6q-usbphy" for imx6dq and imx6dl
> >>     * "fsl,imx6sl-usbphy" for imx6sl
> >>
> >> It makes it a bit easier to read.
> > 
> > Thanks, will change like above.
> > 
> >>
> >> I see the existing "fsl,imx23-usbphy" is used as a fallback for
> >> "fsl,imx28-usbphy", "fsl,imx6q-usbphy", and "fsl,imx6sl-usbphy" in
> >> existing DTs.
> >>
> >> Is this expected going forward? It might be worth mentioning.
> >>
> > 
> > These SoCs used the same FSL imx PHY, but different versions.
> > imx23/imx28 are the first version, more improvements are at
> > later SoCs (like imx6x) version. Keep "fsl,imx23-usbphy" at
> > imx6 dts will be user know it is from imx23's. If you think
> > it does not need, I can delete "fsl,imx23-usbphy" from imx6 dts.
> 
> You should go after compatibility here. List (all) phys that are
> comaptible, start with most specific end with most generic.
> 
> Marc
> 

Then, I should keep imx6 dts unchanging. Then, what I need to
mention at this binding doc? 

-- 

Best Regards,
Peter Chen
