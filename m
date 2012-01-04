From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 4 Jan 2012 17:35:39 -0600
Subject: [RFC PATCH v2 2/2] ARM: imx: Add mx5 cpuidle implmentation
In-Reply-To: <20111222175027.GG29622@opensource.wolfsonmicro.com>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-3-git-send-email-rob.lee@linaro.org>
 <20111222175027.GG29622@opensource.wolfsonmicro.com>
Message-ID: <CAMXH7KEHsighKYkPhhgHmE9s7sxtP4hz8L+Z+LMsrD14kiqJJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2011 11:50, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 14, 2011 at 01:02:06AM -0600, Robert Lee wrote:
>
>> + ? ? clk_enable(&gpc_dvfs_clk);
>
> Should these enables be in the cpuidle code? ?The device appears to have
> been working fine without them thus far... ?Alternatively, if they
> should be on anyway does this need to be split out and sent as a bug
> fix?

This clock is used by the existing pm_suspend code for i.MX51 and
other future code being worked on.  Since it uses extremely minimal
power and is required to be enabled during low power modes, it seemed
cleanest to just enable it during clock init.  But I forgot to remove
it from it's enabling from i.MX51 pm_suspend code so I can do that for
v3.
