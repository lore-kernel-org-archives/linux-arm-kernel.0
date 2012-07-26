From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 16:01:14 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <20120726142825.GK3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <50114D71.9060700@linaro.org>
 <20120726142825.GK3099@opensource.wolfsonmicro.com>
Message-ID: <50115BBA.2020400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 15:28, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 03:00:17PM +0100, Lee Jones wrote:
>> On 26/07/12 12:50, Mark Brown wrote:
>
>>> Yet again no binding documentation....
>
>> RFC. ;)
>
>> I'll write the documentation when/if the properties are accepted.
>
> No, write the documentation.  It's way too much effort to reverse
> engineer the bindings from the code.
>
>>>> +		default :
>>>> +			codec->ear_cmv = EAR_CMV_UNKNOWN;
>>>> +			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");
>
>>> The platform data code picks a default, can't the DT code do the same?
>
>> No, I don't think that it does? The original code returns -EINVAL
>> unless a value is specified.
>
> The code doesn't specify values for the enumeration so it ought to
> default to EAR_CMV_0_95V if nothing is specified.

Ah, I see what you mean. I guess we could compromise and print a warning 
_and_ fall back to the 0th original emum.

>> The original author is keen to have a clear error message in case
>> users try to specify non-exact values. I'd rather we fail-out than
>> use incorrect values which would be a great deal harder for a user
>> to debug.
>
> By that argument all the properties should be mandatory but it's only
> this one IIRC.

This is the only value which the user can pick an obscure value, such as 
913, thinking they can pick 913mV. I'm happy to fall-back, as long as 
Ola is too.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
