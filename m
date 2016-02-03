From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 03 Feb 2016 11:45:56 +0900
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D64026A0@penmbx01>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
 <20160129113518.GQ4130@sirena.org.uk> <87wpqn3t72.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D64026A0@penmbx01>
Message-ID: <56B169E4.9030801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.02.2016 11:29, Yang, Wenyou wrote:
> Hi Peter,
> 
>> -----Original Message-----
>> From: Peter Korsgaard [mailto:jacmet at gmail.com] On Behalf Of Peter Korsgaard
>> Sent: 2016?2?3? 1:42
>> To: Mark Brown <broonie@kernel.org>
>> Cc: Yang, Wenyou <Wenyou.Yang@atmel.com>; Liam Girdwood
>> <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
>> <pawel.moll@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
>> Gala <galak@codeaurora.org>; Krzysztof Kozlowski
>> <k.kozlowski@samsung.com>; Javier Martinez Canillas <javier@dowhile0.org>;
>> Lee Jones <lee.jones@linaro.org>; Peter Korsgaard <jacmet@gmail.com>; Ferre,
>> Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org;
>> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org
>> Subject: Re: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
>> ACT8945A
>>
>>>>>>> "Mark" == Mark Brown <broonie@kernel.org> writes:
>>
>>  > On Fri, Jan 29, 2016 at 01:20:08AM +0000, Yang, Wenyou wrote:
>>  >> > > +static const struct of_device_id act8945a_pmic_of_match[] = {
>>  >> > > +	{ .compatible = "active-semi,act8945a-regulator" },
>>  >> > > +	{ },
>>  >> > > +};
>>  >> > > +MODULE_DEVICE_TABLE(of, act8945a_pmic_of_match);
>>
>>  >> > This seems mostly OK but why do we have a compatible string here -
>> shouldn't  >> > the MFD be able to instantiate the regulator function without
>> needing this?
>>
>>  >> Because I got feedback from Javier for the act8945a-charger patches of this
>> MFD series,  >> He said missing the OF match table will cause the module
>> autoloading broken.
>>
>>  >> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398113.html
>>
>>  >> What do you think about it?
>>
>>  > If then device is not being loaded from the DT (and it shouldn't be, the  > device
>> looks like it should be instantiated directly by the MFD as it  > can't exist
>> separately to that MFD) an OF table will do nothing.
>>
>> To add to the confusion, the regulator part of the chip is actually identical to
>> act8865, so it could use the existing regulator driver / compatible, except that it
>> binds to the platform bus instead of i2c.
> 
> Thank you for your opinion.
> 
> But I think It is better to make it a separate driver, the driver is simpler. 

Do I understand correctly that you are creating a new device driver for
the same logical device (regulator block)?

By duplicating the code you are not making kernel simpler. Maybe your
new driver will be simple but still this adds a NEW driver instead of
re-using existing code.

Best regards,
Krzysztof
