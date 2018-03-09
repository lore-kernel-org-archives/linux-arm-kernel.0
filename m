From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 9 Mar 2018 15:49:00 +0530
Subject: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180309034332.GO6842@vireshk-i7>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
 <20180307050624.GR23018@vireshk-i7>
 <20180308201438.GA10589@jcrouse-lnx.qualcomm.com>
 <20180309034332.GO6842@vireshk-i7>
Message-ID: <4fd61bd2-757b-ef30-a07f-ed74af031ff5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Jordan/Viresh,

On 03/09/2018 09:13 AM, Viresh Kumar wrote:
> On 08-03-18, 13:14, Jordan Crouse wrote:
>> It seems to me that performance_state has a direct relationship with genpd
>> which is good for CPU votes but in this case, we're just passing along raw data
>> to an independent microcontroller. The 'qcom,arc-level' is used to construct
>> the actual values that the GMU will program into the RPMh. Since these are
> 
> The "genpd" here is created specially for this RPM. The performance-state thing
> is designed to solve this very specific problem of qualcomm SoCs and there is no
> way we are going to add another property for this now.
> 
>> informational (from the CPU perspective) rather than functional I feel like
>> that using performance_state for this would be as hacky as using opp-microvolt
>> or something else.
> 
> There is some WIP stuff here Rajendra is testing currently.

What I am doing is a powerdomain driver to communicate magic values from
CPU to rpmh, looks like we need another one to communicate from CPU to
GMU now :)

A few things,
* someone will need to map these larger magic values into something that
rpmh would understand (between 0 to 15 on the sdm845), thats done by
reading the command db level maps. Is this done by GMU?

* are these communicated just once for every OPP at init/boot, or for
every OPP switch?

* whats the communication mechanism we use between CPU and GMU? 

regards
Rajendra

> 
> ssh://git at git.linaro.org/people/viresh.kumar/mylinux.git opp/genpd/qcom
> 
> Please have a talk with Rajendra who can help you understand on how this can be
> used for GPUs.
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
