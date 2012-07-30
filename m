From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 14:57:12 +0100
Subject: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <20120730133930.GB4468@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
 <50162F70.2050900@linaro.org>
 <20120730133930.GB4468@opensource.wolfsonmicro.com>
Message-ID: <501692B8.6050102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 14:39, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 07:53:36AM +0100, Lee Jones wrote:
>> On 29/07/12 21:42, Mark Brown wrote:
>
>>>> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
>
>>> This doesn't seem particularly sane...  why is this conditional?
>
>> It's conditional because only MSP1 and MSP3 have pinctrl support.
>
> Why does the driver care - doesn't the pinctrl abstraction and/or
> bindings handle this sensibly?

Not when I tested it. pinctrl_get() came back !IS_ERR() for MSP0, MSP2 & 
MSP3, then when it went on to pinctrl_lookup_state(), only then did it 
fail. Would it be more sane to retract the error messages and just let 
it fail silently? It's either that or have lots of "could not get MSP 
defstate" clogging up the log.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
