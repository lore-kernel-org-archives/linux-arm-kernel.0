From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Nov 2013 10:07:57 +0000
Subject: [PATCH v3 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <1385114292.29083.8.camel@AMDC1943>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-2-git-send-email-k.kozlowski@samsung.com>
 <20131122093118.GH23067@lee--X1>
 <1385114292.29083.8.camel@AMDC1943>
Message-ID: <20131122100757.GI23067@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +static struct mfd_cell max14577_devs[] = {
> > > +	{ .name = "max14577-muic", },
> > > +	{ .name = "max14577-regulator", },
> > > +	{ .name = "max14577-charger", },
> > > +};
> > 
> > If these all support device tree, shouldn't you be populating
> > max14577_devs[x].of_compatible too? That way the MFD core will
> > automatically setup your dev.of_node pointers for you?
> 
> Only the regulator driver uses bindings from DT and it searches for
> "regulators" node in parent's node:
> 	np = of_get_child_by_name(max14577->dev->of_node, "regulators");
> I can add of_compatible but I think this won't be reflected in actual
> DTS.

Well it should be. I'll reply to the other patch too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
