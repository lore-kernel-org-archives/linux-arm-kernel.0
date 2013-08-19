From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 10:25:44 -0600
Subject: [PATCH 2/5] clk: tegra: Add reset only clock node flag and COP
In-Reply-To: <20130819145353.GP18810@tbergstrom-lnx.Nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
 <1375874709-10438-2-git-send-email-markz@nvidia.com>
 <52027C9B.2030009@wwwdotorg.org>
 <20130819145353.GP18810@tbergstrom-lnx.Nvidia.com>
Message-ID: <52124708.20205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 08:53 AM, Peter De Schrijver wrote:
> On Wed, Aug 07, 2013 at 06:58:03PM +0200, Stephen Warren wrote:
>> On 08/07/2013 05:25 AM, Mark Zhang wrote:
>>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>
>>> COP is a reset only clock. So this patch adds NO_CLK support
>>> then adds the COP clock.
>>
>> Do we actually need this clock upstream yet?
>>
>> IIRC, Prashant was working on implementing the common reset API, so I'd
>> prefer not to add any reset-only "clocks" to the clock driver, but
>> rather to simply make sure that the new reset driver exposes them.
>>
> 
> It would be better if we can switch to the reset API.
> 
>>> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
>>
>>>  enum tegra114_clk {
>>> -	rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,
>>> +	cop = 1, rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,
>>
>> To make this change, you would also need to edit
>> include/dt-bindings/clock/tegra114-car.h. BTW, why doesn't the Tegra
>> clock driver include that file rather than defining its own enum?
> 
> History. include/dt-bindings/clock/tegra114-car.h didn't exist when
> clk-tegra114.c was written.

Right, but then someone created tegra114-car.h, but didn't bother to
follow through and update the clock driver:-(
