From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Mar 2011 10:15:05 -0800
Subject: [PATCH] perf: add OMAP support for the new power events
In-Reply-To: <AANLkTikaQ69Rt9Q6vtm8F_S=qLftM=yqjrUcTqj2Rihm@mail.gmail.com>
	(Jean Pihet's message of "Thu, 10 Mar 2011 09:09:37 +0100")
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<1299147943-2929-1-git-send-email-j-pihet@ti.com>
	<878vwnvnvj.fsf@ti.com>
	<AANLkTikaQ69Rt9Q6vtm8F_S=qLftM=yqjrUcTqj2Rihm@mail.gmail.com>
Message-ID: <87k4g6deqe.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 10, 2011 at 1:08 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> The patch adds the new power management trace points for
>>> the OMAP architecture.
>>>
>>> The trace points are for:
>>> - default idle handler. Since the cpuidle framework is
>>> ? instrumented in the generic way there is no need to
>>> ? add trace points in the OMAP specific cpuidle handler;
>>> - cpufreq (DVFS),
>>
>> Minor: AFAICT, this patch doesn't instrument CPUfreq.
> The generic framework provides a cpu_frequency event. Furthermore the
> clock_set_rate events are reporting the various SoC clock rate
> changes.
> Indeed the changelog is not accurate enough. Is '- cpufreq (DVFS)
> events are covered by the generic cpu_frequency events and the SoC
> clock changes events' better?

I'd prefer to just leave this out as either way, I find it confusing
based on the content of this patch.

Kevin
