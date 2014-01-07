From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Tue, 07 Jan 2014 15:55:45 +0000
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
In-Reply-To: <4325123.pn10H18tk9@wuerfel>
References: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
 <52CBF606.5080209@arm.com> <4325123.pn10H18tk9@wuerfel>
Message-ID: <52CC2381.2090905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 12:54, Arnd Bergmann wrote:
> On Tuesday 07 January 2014 12:41:42 Sudeep Holla wrote:
>> Hi Tushar,
>>
>> This has been discussed couple of times in past[1][2], and the opinion was not
>> to have these in DT as they are more configuration data than the actual hardware
>> description.
> 
> How do you suggest we get rid of the magic constants in platform code then?
> I definitely don't want to keep the current state, and having configuration
> data in DT seems the lesser evil.
> 

I agree, but since these are more L2CC configuration than hardware description,
IMO chosen node is one option. However it's good to get opinion from DT guys.

> Are there some reasonable defaults that Linux could use independent of the
> platform and of what the boot loader defaults to?
> 

Most of these registers can't be programmed in Non-secure mode. So as mentioned
already in previous discussions it is better to avoid these settings in kernel.
It would be better if bootloader programs these settings even if Linux runs in
secure mode for simplicity.

Regards,
Sudeep
