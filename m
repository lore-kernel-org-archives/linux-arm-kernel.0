From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 20:20:24 +0100
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <20130325190908.GC631@lunn.ch>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
 <20130325190908.GC631@lunn.ch>
Message-ID: <5150A378.60608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 08:09 PM, Andrew Lunn wrote:
>>> Please could you add a comment in the code about which piece is
>>> specific to ARM, because its not obvious to me. Its not like there is
>>> a reference to WFI for example. It looks like this code could go in
>>> drivers/cpuidle/cpuidle.c
>>
>> Yes, I agree. At the first glance, the code, as it is, could go in this
>> file but more ARM specific code will be moved to this ARM generic code
>> driver like device tree description and couple idle states. The init
>> function would be more arch specific then.
> 
> Hi Daniel
> 
> There was a discussion about device tree bindings when i posted
> the kirkwood cpuidle driver, now in drivers/cpuidle/cpuidle-kirkwood.c.
> 
> The conclusion was that pseudo devices, like cpuidle, do not have DT
> bindings. They can check of_machine_is_compatible(), like
> cpuidle-calxeda.c does, or they are platform drivers, which is what
> cpuidle-kirkwood.c is.
> 
> Even if DT binding was allowed, it again should not be ARM specific.

If the DT binding was allowed, I *may* not be ARM specific but will
certainly used only by the ARM drivers as the x86 platform uses ACPI or
static tables.

> Are coupled idle states ARM specific?

Well the code is not arch specific but today the idle coupling is ARM
specific because it is the only arch using this kind of synchronization.
There is also a last man standing algorithm common to ux500 and imx
(maybe exynos soon) I would like to merge into this ARM driver.

AFAIK, the cluster shutdown is managed by the hardware on x86 so there
is no need for this.




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
