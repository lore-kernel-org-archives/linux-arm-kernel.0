From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Nov 2013 10:58:12 +0100
Subject: [PATCH v3 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <20131122093118.GH23067@lee--X1>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-2-git-send-email-k.kozlowski@samsung.com>
 <20131122093118.GH23067@lee--X1>
Message-ID: <1385114292.29083.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 2013-11-22 at 09:31 +0000, Lee Jones wrote:
(...)
> > +static struct mfd_cell max14577_devs[] = {
> > +	{ .name = "max14577-muic", },
> > +	{ .name = "max14577-regulator", },
> > +	{ .name = "max14577-charger", },
> > +};
> 
> If these all support device tree, shouldn't you be populating
> max14577_devs[x].of_compatible too? That way the MFD core will
> automatically setup your dev.of_node pointers for you?

Only the regulator driver uses bindings from DT and it searches for
"regulators" node in parent's node:
	np = of_get_child_by_name(max14577->dev->of_node, "regulators");
I can add of_compatible but I think this won't be reflected in actual
DTS.

> <snip>
> 
> > +	max14577->vendor_id = (reg_data & 0x7);
> > +	max14577->device_id = ((reg_data & 0xF8) >> 0x3);
> 
> I'm not too keen on these magic numbers, can you create #defines for
> them please? If there are any other interesting address, it might be
> worth creating some for those too.

OK, I'll define these.

Best regards,
Krzysztof
