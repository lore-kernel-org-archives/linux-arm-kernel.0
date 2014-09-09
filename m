From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 9 Sep 2014 11:26:55 +0100
Subject: [PATCH v2 1/4] phy: phy-stih407-usb: Add usb picoPHY driver
 found on stih407 SoC family
In-Reply-To: <2894228.eRmxgHsWbh@wuerfel>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
 <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
 <2894228.eRmxgHsWbh@wuerfel>
Message-ID: <20140909102655.GA8544@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for reviewing :-)

> > +	phy = devm_phy_create(dev, NULL, match->data, NULL);
> > +	if (IS_ERR(phy)) {
> > +		dev_err(dev, "failed to create Display Port PHY\n");
> > +		return PTR_ERR(phy);
> > +	}
> > +
> 
> There is only one entry in the match table, so it always points to
> stih407_usb2_picophy_data. Do you have plans to add another set of
> operations soon?

Nope.

> If not, just remove the .data pointer and hardcode the operations
> in the devm_phy_create call.

I've done as you suggest in v3 which I will send shortly.

regards,

Peter.
