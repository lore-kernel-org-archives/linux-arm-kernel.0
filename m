From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 15:21:53 +0100
Subject: AB8500 Regulators
In-Reply-To: <20120731134716.GL4468@opensource.wolfsonmicro.com>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
 <20120730174831.GP4468@opensource.wolfsonmicro.com>
 <50179B64.60209@linaro.org>
 <20120731110830.GY4468@opensource.wolfsonmicro.com>
 <5017CEE4.5010602@linaro.org>
 <20120731134716.GL4468@opensource.wolfsonmicro.com>
Message-ID: <5017EA01.6090401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 14:47, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 01:26:12PM +0100, Lee Jones wrote:
>> On 31/07/12 12:08, Mark Brown wrote:
>
>>>> - I now know how the changing voltage API works
>>>>    - What I don't know is where we'd call it from to initialise them
>>>>    - Can we do that from the ab8500 regulator driver's init() or probe()?
>
>>> I'm surprised you've managed to miss the existing interfaces:
>
>>>     include/linux/regulator/machine.h
>>>     Documentation/devicetree/bindings/regulator/regulator.txt
>
>> I saw the interfaces, I just don't know what's the correct thing to
>> do. I'm leaving Device Tree for the moment. I'm more concerned about
>> addressing the problem in the AB8500 Regulator Driver and it's
>> Platform counterpart.
>
>> The only thing of interest that I could see was the regulator_init()
>> call-back. Is this what you were alluding to in the first link?
>
> No.  apply_uV.

Ah, nice.

So is it worth me making at least those changes, so we can start 
thinning down our platform data overhead?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
