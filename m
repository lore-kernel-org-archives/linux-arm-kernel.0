From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 10 Feb 2012 22:18:59 -0800
Subject: [PATCH 0/3] pinctrl: move the core per-device handlers to core
In-Reply-To: <CACRpkdZ0kTXLAfdsfMjeZZX4W-fx5zyEdeGboKCmKSzCaMVw_A@mail.gmail.com>
References: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
 <4F34A3EF.3070207@nvidia.com>
 <CACRpkdZ0kTXLAfdsfMjeZZX4W-fx5zyEdeGboKCmKSzCaMVw_A@mail.gmail.com>
Message-ID: <4F360853.3050402@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2012 12:51 PM, Linus Walleij wrote:
> On Fri, Feb 10, 2012 at 5:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
>>> These three patches take the first step in this transformation by moving
>>> the per-device handles over to core code, and renaming all related
>>> functions with the pinctrl_* prefix.
>>
>> The series,
>> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Thanks, I've managed to push this to -next with the v2 version of
> [2/3] and the hog patch.
> 
>> Note that this series will cause some compile breakage in the series I
>> previously posted to add a pinctrl-tegra driver and convert mach-tegra
>> to use it. The following patches in that series should still be OK:
>>
>> pinctrl: add a driver for NVIDIA Tegra
>> ARM: tegra: Select PINCTRL Kconfig variables
>>
>> ... so you can still go ahead and apply those, but the following will be
>> broken:
>>
>> ARM: tegra: Switch to new pinctrl driver
>> ARM: tegra: Remove pre-pinctrl pinmux driver
>>
>> also the separately posted:
>>
>> ARM: tegra: Add pinmux board file for Cardhu
>>
>> I'll probably hold off reposting those last 3; with any luck they'll be
>> eclipsed by my implementing full DT binding support in the near future,
>> given our consensus on that topic following discussion at Linaro Connect.
> 
> OK, alternatively I could remove these for the time being, or I
> can fix up the mess I created if you prefer, by just adding
> a patch on top, so it gets changed over no matter if the
> DT stuff gets sorted out for this merge window?

I'll probably want to rework the 3 patches your changes break anyway (in
order to completely remove use of board-*-pinmux.c when booting from DT,
once I write the DT code) and so you may as well not apply them, just
the driver itself. It'll save some churn.

-- 
nvpublic
