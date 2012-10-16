From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Oct 2012 11:03:43 -0600
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <20121016080634.GG3196@tbergstrom-lnx.Nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
 <507885D4.10604@wwwdotorg.org>
 <1350287799.23354.23.camel@jlo-ubuntu-64.nvidia.com>
 <507C32E8.1040701@wwwdotorg.org>
 <20121016080634.GG3196@tbergstrom-lnx.Nvidia.com>
Message-ID: <507D936F.70905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 02:06 AM, Peter De Schrijver wrote:
>>> Even though we have plan to use coupled cpuidle, I still prefer to go
>>> with the LP2 driver first. Then adding one more patch to support coupled
>>> cpuidle based on LP2 driver. This is good for history. And if there is
>>> any issue, it's more easy to roll back to the stable one.
>>
>> I don't think that implementing it one way and then changing to a
>> different way will benefit history at all. It'll make the history more
>> complicated. What exactly is the problem with just using coupled cpuidle
>> from the start? If we did merge this implementation now, then switch to
>> coupled cpuidle later, when do you think the switch would happen?
> 
> Before we consider doing this, I think we should have some idea on how
> frequently we run into the situation where CPU0 is idle but a secondary
> core is not. Depending on that we can then decide how useful coupled cpuidle
> would be for us.

Would it not be 75% of the time where we have 1 of 4 CPUs active? At
least, that's assuming that all work is evenly distributed amongst CPUs,
and hence it's random which CPU is the last to go idle, but perhaps
that's not the case if CPU0 is somehow special workload-wise?

But yes, some stats gathered from real-world use-cases could well be
interesting.
