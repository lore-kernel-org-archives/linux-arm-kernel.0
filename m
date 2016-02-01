From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 1 Feb 2016 05:54:46 +0000
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <CABxcv=kNKmgRytxB5ppawrAvC-GDRhV4T_UUGvpHgKp9+BsUmQ@mail.gmail.com>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
 <20160129113518.GQ4130@sirena.org.uk>
 <CABxcv=kNKmgRytxB5ppawrAvC-GDRhV4T_UUGvpHgKp9+BsUmQ@mail.gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63FE2C7@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier & Mark,

I am educated. Thank you all.

> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javier at dowhile0.org]
> Sent: 2016?1?29? 19:50
> To: Mark Brown <broonie@kernel.org>
> Cc: Yang, Wenyou <Wenyou.Yang@atmel.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
> <pawel.moll@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; Lee Jones <lee.jones@linaro.org>; Peter
> Korsgaard <jacmet@gmail.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
> ACT8945A
> 
> Hello Mark,
> 
> On Fri, Jan 29, 2016 at 8:35 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Jan 29, 2016 at 01:20:08AM +0000, Yang, Wenyou wrote:
> >
> >> > > +static const struct of_device_id act8945a_pmic_of_match[] = {  {
> >> > > +.compatible = "active-semi,act8945a-regulator" },  { }, };
> >> > > +MODULE_DEVICE_TABLE(of, act8945a_pmic_of_match);
> >
> >> > This seems mostly OK but why do we have a compatible string here -
> >> > shouldn't the MFD be able to instantiate the regulator function without
> needing this?
> >
> >> Because I got feedback from Javier for the act8945a-charger patches
> >> of this MFD series, He said missing the OF match table will cause the module
> autoloading broken.
> >
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/39
> >> 8113.html
> >
> >> What do you think about it?
> >
> > If then device is not being loaded from the DT (and it shouldn't be,
> > the device looks like it should be instantiated directly by the MFD as
> > it can't exist separately to that MFD) an OF table will do nothing.
> 
> Then he should remove the .of_compatible from the MFD cell definition.

I tried it,

But if removed this .of_compatible, and reserved the OF table. 
the &pdev->dev->of_node is NULL, the driver fails to get the configuration value from DT, 

It seems the OF table still doesn't work. Where is wrong?

Could you help give some suggestion?

> 
> Otherwise the MFD core will assign an of_node to this device in mfd_add_device(),
> making the platform core to believe the device was instantiated by OF. So an OF
> modalias uevent will be reported to load the module and the OF table should be
> used for matching the device with the driver.
> 
> IOW, the MFD and regulator driver have to agree on this. Either everything should
> have OF or platform information, both work but mixing these as it was on a
> previous version doesn't.
> 
> Best regards,
> Javier


Best Regards,
Wenyou Yang
