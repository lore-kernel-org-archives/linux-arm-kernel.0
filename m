From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Mar 2018 10:36:24 +0530
Subject: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
Message-ID: <20180307050624.GR23018@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-03-18, 08:37, Jordan Crouse wrote:
> I'll try to explain but I might need Stephen or some of the other folks to jump
> in and save me.

Maybe you should start using his kernel.org address then ? :)

> On sdm845 there are shared power resources controlled by the RPMh which is
> programed by a series of commands from the regulator driver; but in the case
> of the GPU the votes are passed to the GMU (graphics management unit) which
> communicates with the RPMh on behalf of the GPU.
> 
> In order to construct the RPMh vote we need first need a voltage level that we
> can look up in a database. qcom,arc-level is the voltage level associated with
> a specific OPP.
> 
> I had previously been abusing this with opp-microvolt but that was wrong for
> obvious reasons and then Stephen pointed out that this would be a better way.

Glad that you shared that :)

A solution is already in progress for that and is partially merged as
well.

Look for "performance_state" in genpd and OPP cores (already merged),
followed by this series here:

https://lkml.kernel.org/r/cover.1513926033.git.viresh.kumar at linaro.org

-- 
viresh
