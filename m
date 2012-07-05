From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 13:55:50 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <20120705124549.GD4111@opensource.wolfsonmicro.com>
References: <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
 <20120703142123.GQ29030@opensource.wolfsonmicro.com>
 <4FF54406.3000307@linaro.org>
 <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
 <20120705122947.GY4111@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
Message-ID: <4FF58ED6.40106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 13:45, Mark Brown wrote:
> On Thu, Jul 05, 2012 at 01:41:12PM +0100, Lee Jones wrote:
>> On 05/07/12 13:29, Mark Brown wrote:
>
>> If DT is _not_ enabled, we do:
>
>>    From platform code:
>>     - Register the DB8500-PRCMU
>>     - Register the AB8500
>
>> So you see the registration is separate.
>
> Right, so what I'm saying is that what I'd expect unless there's
> something unusual going on is that you wouldn't be doing the separate
> registration of the AB8500 here and would instead be passing the
> platform data for the AB8500 through in the same way you pass the DT
> data through.

Then were would you register it, if not here?

> DT and non-DT do have a very similar model for this stuff.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
