From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 21 Jan 2016 01:10:59 +0000
Subject: [PATCH v6 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
In-Reply-To: <20160120113229.GB29000@x1>
References: <1453274383-24835-1-git-send-email-wenyou.yang@atmel.com>
 <20160120113229.GB29000@x1>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63F6ADA@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Lee Jones [mailto:lee.jones at linaro.org]
> Sent: 2016?1?20? 19:32
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Rob
> Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark
> Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; Javier Martinez Canillas <javier@dowhile0.org>;
> Peter Korsgaard <jacmet@gmail.com>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-pm at vger.kernel.org
> Subject: Re: [PATCH v6 0/2] power: act8945a: add charger driver for the sub-
> device of ACT8945A MFD
> 
> It really is unacceptable to be sending out so many versions at such short
> intervals, essentially spamming the list.  This infraction is worsened by the
> amount of people you have on CC, most of them for no reason.  This set shouldn't
> hit my inbox at all, let alone 4 times in one day!

Sorry!

Next time I will be careful.

> 
> > The ACT8945A is a Multi Function Device with the following subdevices:
> >  - Regulator
> >  - Charger
> >
> > This patch set is to add regulator driver for ACT8945A.
> > It is based on the patch set:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400
> > 534.html
> >
> > Changes in v6:
> >  - change the type value to unsigned int.
> >
> > Changes in v5:
> >  - remove spare spaces after #define.
> >  - add OF match table.
> >  - collect Reviewed-by from Krzysztof.
> >
> > Changes in v4:
> >  - use spaces after #define, not tabs.
> >  - use BIT(n) macros to substitute (0x01 << x).
> >  - change dt properties with more legible name.
> >  - change the properties with more legible name, clearer description.
> >
> > Changes in v3:
> >  - update the file header with short version license and author line.
> >  - remove unused member of struct act8945a_charger, dev.
> >  - action due to removing the member of stuct act8945a_dev, dev.
> >  - remove the unnecessary print out.
> >  - remove the unnecessary act8945a_charger_remove().
> >  - fix align of the code-style.
> >
> > Changes in v2:
> >  1./ Substitute of_property_read_bool() for of_get_property().
> >  2./ Substitute devm_power_supply_register() for power_supply_register().
> >  3./ Use module_platform_driver(), instead of subsys_initcall().
> >  4./ Substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").
> >
> > Wenyou Yang (2):
> >   power: act8945a: add charger driver for ACT8945A
> >   power: add documentation for ACT8945A's charger DT bindings
> >
> >  .../devicetree/bindings/power/act8945a-charger.txt |   33 ++
> >  drivers/power/Kconfig                              |    7 +
> >  drivers/power/Makefile                             |    1 +
> >  drivers/power/act8945a_charger.c                   |  375 ++++++++++++++++++++
> >  4 files changed, 416 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/power/act8945a-charger.txt
> >  create mode 100644 drivers/power/act8945a_charger.c
> >
> 
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead Linaro.org ? Open source
> software for ARM SoCs Follow Linaro: Facebook | Twitter | Blog


Best Regards,
Wenyou Yang
