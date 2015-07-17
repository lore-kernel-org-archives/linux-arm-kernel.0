From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 17 Jul 2015 11:08:04 +0530
Subject: [PATCH 5/5] regulator: 88pm800: Add support for configuration
 of dual phase on BUCK1
In-Reply-To: <20150716203232.GA1602@sirena.org.uk>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437070618-21330-6-git-send-email-vaibhav.hiremath@linaro.org>
 <20150716203232.GA1602@sirena.org.uk>
Message-ID: <55A894BC.8070401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 17 July 2015 02:02 AM, Mark Brown wrote:
> On Thu, Jul 16, 2015 at 11:46:58PM +0530, Vaibhav Hiremath wrote:
>
>>   	.disable		= regulator_disable_regmap,
>>   	.is_enabled		= regulator_is_enabled_regmap,
>>   	.get_current_limit	= pm800_get_current_limit,
>> +	.set_current_limit	= pm800_set_current_limit,
>
> set_current_limit() isn't the right interface to use for this, this is
> something that depends on the physical design of the system rather than
> something that limits the current.  It should be a DT property of its
> own.  There are some other PMICs with similar functions but it's not
> clear yet how generic the configuration mechanism is.
>

Hmmm,
Yeah, right. This is depends on physical design. And not the regulator
current limit.

Earlier, I had submitted DT based approach, but was MFD DT property.
Which is not correct, do you think regulator DT property is the right
approach?

Below is going to be my approach -

pmic1: 88pm860 at 30 {
	compatible = "marvell,88pm800";
	...
	regulators {
		compatible = "marvell,88pm80x-regulator";

		marvell,88pm860-buck1-dualphase-en;

		buck1: buck1 {
			...
		};
		...
	};
};


Thanks,
Vaibhav
