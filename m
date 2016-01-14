From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jan 2016 06:19:36 +0000
Subject: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63EBC6E@penmbx01>
References: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
 <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com>
 <87oacp5zl7.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBC6E@penmbx01>
Message-ID: <20160114061936.GM27358@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jan 2016, Yang, Wenyou wrote:

> > -----Original Message-----
> > From: Peter Korsgaard [mailto:jacmet at gmail.com] On Behalf Of Peter Korsgaard
> > Sent: 2016?1?13? 22:22
> > To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark
> > Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> > Kumar Gala <galak@codeaurora.org>; Krzysztof Kozlowski
> > <k.kozlowski@samsung.com>; devicetree at vger.kernel.org; Ferre, Nicolas
> > <Nicolas.FERRE@atmel.com>; linux-kernel at vger.kernel.org; Javier Martinez
> > Canillas <javier@dowhile0.org>; Lee Jones <lee.jones@linaro.org>; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
> > ACT8945A
> > 
> > >>>>> "Wenyou" == Wenyou Yang <wenyou.yang@atmel.com> writes:
> > 
> >  > This patch adds new regulator driver to support ACT8945A MFD  > chip's
> > regulators.
> > 
> >  > The ACT8945A has three step-down DC/DC converters and four  > low-dropout
> > regulators.
> > 
> >  > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > 
> > Isn't the regulator part of the act8945a identical to act8865? Can't we just use the
> > existing act8865-regulator.c driver? (E.G. support 8865 variant in the mfd driver,
> > but only register the regulator sub device?)
> 
> Yes, the regulator part of the act8945a is identical to act8865.
> 
> But the act8865-regulator driver is a struct i2c_driver,  and the mfd sub-device driver is a platform_driver driver, it is not easy to use it.

Take a look at some existing files with the pattern
drivers/mfd/*{spi,i2c,core}.c to see how this might be possible.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
