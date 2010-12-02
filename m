From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 2 Dec 2010 10:41:27 +0800
Subject: [PATCHv2] make mc13783 regulator code generic
In-Reply-To: <20101201112515.GC24176@rakim.wolfsonmicro.main>
References: <AANLkTi=E8etAOPTCBw8ccTZ9LMU-Yf=wELn+VQkg2eom@mail.gmail.com>
	<20101201112515.GC24176@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikyNNSbx2hWjWh4WFKbyGcii_QxqpTneVygwJMN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please see inline feedback.

On Wed, Dec 1, 2010 at 7:25 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 01, 2010 at 03:15:55PM +0800, Yong Shen wrote:
>
>> ?move some common functions and micros of mc13783 regulaor driver to
>> a seperate file, which makes it possible for mc13892 to share code.
>
> You've done way more than this in the patch - you've also renamed a lot
> of things and done other restructurings. ?I'd suggest splitting out the
> big mechanical changes for easier review. ?For example, a patch moving
> code from one place to another, another patch renaming things and so on.
>
>> +config REGULATOR_MC13XXX_CORE
>> + ? ? tristate "Support regulators on Freescale MC13xxx PMIC"
>> +
>
> This doesn't need to be user visible - the user only cares about the
> individual regulator drivers.
>
>> ? ? ? /* Power Gate enable value is 0 */
>> - ? ? if (id == MC13783_REGU_PWGT1SPI ||
>> - ? ? ? ? id == MC13783_REGU_PWGT2SPI)
>> + ? ? if (id == MC13783_REG_PWGT1SPI ||
>> + ? ? ? ? id == MC13783_REG_PWGT2SPI)
>> ? ? ? ? ? ? ? en_val = 0;
>
> I can't tell what the actual change is here?
The macro names changed. And this will go into a separate patch.
>
>> +int mc13xxx_sw_regulator(struct regulator_dev *rdev)
>> +{
>> + ? ? return 0;
>> +}
>> +
>
> Eh?
Confused naming and it is not necessary. it will be removed.
>
>> +MODULE_ALIAS("platform:mc13xxx-regulator-core");
>
> Is there really going to be a platform device for this?
ACKed.
>
>> +++ b/include/linux/regulator/mc13xxx.h
>
> Pretty much everything in this file is internal to the driver and
> shouldn't be in include/linux.
>
ACKed.
