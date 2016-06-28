From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 08:55:23 +0100
Subject: [PATCH 6/7] phy: miphy28lp: Inform the reset framework that our
 reset line may be shared
In-Reply-To: <57568D05.6020001@ti.com>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-7-lee.jones@linaro.org>
 <57568D05.6020001@ti.com>
Message-ID: <20160628075523.GJ6720@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jun 2016, Kishon Vijay Abraham I wrote:

> 
> 
> On Monday 06 June 2016 09:26 PM, Lee Jones wrote:
> > On the STiH410 B2120 development board the MiPHY28lp shares its reset
> > line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
> > (DRD).  New functionality in the reset subsystems forces consumers to
> > be explicit when requesting shared/exclusive reset lines.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks Kishon.  I'm going to add this to my MFD -fixes submission.

> > ---
> >  drivers/phy/phy-miphy28lp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
> > index 3acd2a1..213e2e1 100644
> > --- a/drivers/phy/phy-miphy28lp.c
> > +++ b/drivers/phy/phy-miphy28lp.c
> > @@ -1143,7 +1143,8 @@ static int miphy28lp_probe_resets(struct device_node *node,
> >  	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
> >  	int err;
> >  
> > -	miphy_phy->miphy_rst = of_reset_control_get(node, "miphy-sw-rst");
> > +	miphy_phy->miphy_rst =
> > +		of_reset_control_get_shared(node, "miphy-sw-rst");
> >  
> >  	if (IS_ERR(miphy_phy->miphy_rst)) {
> >  		dev_err(miphy_dev->dev,
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
