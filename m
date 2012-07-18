From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jul 2012 12:24:15 +0100
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
In-Reply-To: <20120718111226.GH22739@opensource.wolfsonmicro.com>
References: <50066739.4010206@linaro.org>
 <20120718111226.GH22739@opensource.wolfsonmicro.com>
Message-ID: <50069CDF.7000202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/12 12:12, Mark Brown wrote:
> On Wed, Jul 18, 2012 at 08:35:21AM +0100, Lee Jones wrote:
>
> Fix your mailer to word wrap within paragraphs.  I've reformatted your
> mail for legibility.

Does it always do that, or was it just this time? It's setup to 
word-wrap, for instance this paragraph should. I have an add-on, which 
disables wrapping, but I only enable that when I send individual patches 
out. I know it used to work, but I have a feeling it's broken.

>> I agree, but in this instance it really does stand to reason.
>
>> 1. No unified bindings currently exist.
>> 2. I don't have time to create them.
>> 3. It will probably take quite a bit of time for someone else to get
>>     round to creating them.
>> 4. The bindings I'm proposing are siloed by vendor and driver, so will
>>     cause no harm.
>
> Right, this is just a restatement of the standard vendor line.
>
> If the issue is purely about having generic bindings quite frankly it's
> very hard to see how it could take much time or effort to handle the
> generic bits for I2C, it's basically just the maximum bus frequency and

The frequency is already a generic binding, it's the others which need 
alignment.

> possibly also the various fast modes (though to a good approximation it
> seems reasonable to just infer them from the bus frequency and then see
> if we need any more).  One thing I frequently find is that people say
> any sort of generic work is hard without explaining why, if there are
> complex issues that's one thing but that's often not the case.

I didn't say it was hard, I was it was time consuming. It would require 
looking at all of the other drivers and picking out bits which are the 
same. An i2c guy would be better to do it. I didn't even know what the 
nmk-i2c ones were (slsu, tft, rft, sm) until I was told my the author. I 
fear the other drivers will be just as cryptic.

> BTW, looking at the platform data again it seems like i2c_freq_mode it
> seems very odd that it's driver specific?

I agree.

>> 5. I've already volunteered to move them over to the unified ones once
>>     created.
>> 6. These allow support for the driver to work with DT, at the moment
>>     it does not.
>
>> Personally, I think there is more to be gained by applying the
>> (working) vendor specific bindings to the vendor specific driver until
>> some more consolidated ones appear.
>
> Again, vendors always make great promises about how they're going to
> keep everything up to date...

I'm not a vendor. I also keep my promises. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
