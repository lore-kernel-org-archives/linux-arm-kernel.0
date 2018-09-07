From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 07 Sep 2018 12:38:21 +0200
Subject: [PATCH v4 2/2] phy: add Rockchip Innosilicon hdmi phy
In-Reply-To: <81c527fc-5837-658f-5c57-60acd909ed2e@arm.com>
References: <20180906135047.30788-1-heiko@sntech.de>
 <20180906135047.30788-2-heiko@sntech.de>
 <81c527fc-5837-658f-5c57-60acd909ed2e@arm.com>
Message-ID: <7862264.msy1cYF2Tk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 7. September 2018, 10:58:04 CEST schrieb Robin Murphy:
> On 2018-09-06 2:50 PM, Heiko Stuebner wrote:
> > From: Zheng Yang <zhengyang@rock-chips.com>
> > 
> > Add a driver for the Innosilicon hdmi phy used on rk3228/rk3229
> > and rk3328 socs from Rockchip.
> > 
> > Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Robin Murphy <robin.murphy@arm.com>
> 
> That reminds me, I really must dig out that box again and finish 
> figuring out the GPIOs and regulators... :)
>
> [...]
> > +static int inno_hdmi_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct inno_hdmi_phy *inno;
> > +	const struct of_device_id *match;
> > +	struct phy_provider *phy_provider;
> > +	struct resource *res;
> > +	void __iomem *regs;
> > +	int ret;
> > +
> > +	inno = devm_kzalloc(&pdev->dev, sizeof(*inno), GFP_KERNEL);
> > +	if (!inno)
> > +		return -ENOMEM;
> > +
> > +	inno->dev = &pdev->dev;
> > +
> > +	match = of_match_device(inno->dev->driver->of_match_table, inno->dev);
> > +	inno->plat_data = (struct inno_hdmi_phy_drv_data *)match->data;
> 
> Nit: if there's cause to do another respin anyway, you could simplify 
> this part with of_device_get_match_data().

done in v6  ... I found your mail directly after sending v5 ;-) .
