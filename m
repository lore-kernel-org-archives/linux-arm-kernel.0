From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 20 Jan 2016 07:26:56 +0000
Subject: [PATCH v5 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <8737tzz33h.fsf@dell.be.48ers.dk>
References: <1452747845-2962-1-git-send-email-wenyou.yang@atmel.com>
 <1452747845-2962-2-git-send-email-wenyou.yang@atmel.com>
 <87pox41dy9.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63ECA51@penmbx01>
 <8737tzz33h.fsf@dell.be.48ers.dk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63F61F4@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet at gmail.com] On Behalf Of Peter Korsgaard
> Sent: 2016?1?15? 15:58
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
> Pawel Moll <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> devicetree at vger.kernel.org; Krzysztof Kozlowski <k.kozlowski@samsung.com>;
> Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-kernel at vger.kernel.org;
> Javier Martinez Canillas <javier@dowhile0.org>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v5 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC
> MFD driver
> 
> >>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:
> 
> Hi,
> 
>  >> Why not make it a tristate instead? Having regulators as modules is perhaps
> not a  >> very wise thing to do, but conceptually I don't see why this code couldn't
> be a  >> module.
> 
>  > Yes, you are right. it can be use a tristate.
> 
> Ok, good.
> 
> >> > +	act8945a = devm_kzalloc(&i2c->dev, sizeof(*act8945a),
> >> > +GFP_KERNEL);
>  >> > +	if (!act8945a)
>  >> > +		return -ENOMEM;
>  >> > +
>  >>
>  >> What is the point of this structure (and the header file)? Can't the subdevices
> just  >> do dev_get_regmap(dev->parent)? regulator_register() afaik already does
> this by  >> default.
> 
>  > Yes, I re-read regulator_register() code. It did do dev_get_regmap(dev-
> >parent).
> 
>  > I think this structure should be pointed by dev->parent, this structure is
> necessary.
> 
>  > Yes regulator driver should be simpler.
> 
>  > Moreover, it is used by another sub device, charger. Which don't such code.
> 
> But the charger driver can just as well do:
> 
> dev_get_regmap(dev->parent);
> 
> instead of:
> 
> dev_get_drvdata(pdev->dev.parent)->regmap.

For regulator, it works use the core do dev_get_regmap(dev->parent), but for charger, it need to export *act8945a.


Best Regards,
Wenyou Yang
