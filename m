From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Oct 2014 19:45:18 +0300
Subject: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO
 interface
In-Reply-To: <20141028145850.GU18557@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
 <20141028145850.GU18557@sirena.org.uk>
Message-ID: <544FC81E.10408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2014 05:58 PM, Mark Brown wrote:
> On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>> Since LoCoMo driver has been converted to provide proper gpiolib
>> interface, make poodle ASoC platform driver use gpiolib API.
>
> Please use subject lines matching the style for the subsystem.
>
>> +	ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
>> +				ret);
>> +		return ret;
>> +	}
>
> I sense a need for devm_gpio_request_array() here.  Otherwise this looks
> fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
> so no need to block on this.

I like the idea of devm_gpio_request_array. But I would like not to add 
additional (core) patches to this patchset.

>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> with at least the subject line fixed.

Subject line fixed.

-- 
With best wishes
Dmitry
