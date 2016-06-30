From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 09:43:10 +0800
Subject: [PATCH 13/21] usb: chipidea: msm: Allow core to get usb phy
In-Reply-To: <146722867837.16253.5338887948471498730@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-14-stephen.boyd@linaro.org>
 <20160629064811.GH25236@shlinux2> <20160629113411.GO25236@shlinux2>
 <146722867837.16253.5338887948471498730@sboyd-linaro>
Message-ID: <20160630014310.GD19928@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 12:31:18PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-29 04:34:11)
> > On Wed, Jun 29, 2016 at 02:48:11PM +0800, Peter Chen wrote:
> > > On Sun, Jun 26, 2016 at 12:28:30AM -0700, Stephen Boyd wrote:
> > > > @@ -53,21 +44,9 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
> > > >  static int ci_hdrc_msm_probe(struct platform_device *pdev)
> > > >  {
> > > >     struct platform_device *plat_ci;
> > > > -   struct usb_phy *phy;
> > > >  
> > > >     dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> > > >  
> > > > -   /*
> > > > -    * OTG(PHY) driver takes care of PHY initialization, clock management,
> > > > -    * powering up VBUS, mapping of registers address space and power
> > > > -    * management.
> > > > -    */
> > > > -   phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> > > > -   if (IS_ERR(phy))
> > > > -           return PTR_ERR(phy);
> > > > -
> > > > -   ci_hdrc_msm_platdata.usb_phy = phy;
> > > > -
> > > >     plat_ci = ci_hdrc_add_device(&pdev->dev,
> > > >                             pdev->resource, pdev->num_resources,
> > > >                             &ci_hdrc_msm_platdata);
> > > > -- 
> > > 
> > 
> > Wait, how about the UTMI PHY? You don't have a platform which needs
> > to get PHY through the phandle?
> 
> Sorry I don't understand the question. What is the UTMI PHY? We need to
> get the phy through phandles. The only boards that are using ci_hdrc_msm
> are DT enabled boards.

UTMI PHY is the PHY inside the SoC, I just want to confirm all your PHYs
are at ulpi bus, if they are, you can do that, else, you may need above
way to get the PHY through PHY node.

-- 

Best Regards,
Peter Chen
