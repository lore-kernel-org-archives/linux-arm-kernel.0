From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Oct 2017 14:43:01 +0530
Subject: [PATCH 07/34] cpufreq: cris: remove calls to
 cpufreq_notify_transition()
In-Reply-To: <20171010075742.GL17578@axis.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <d8b7b00908f0fa16feca841b1bf7fb1a49c62df1.1376619363.git.viresh.kumar@linaro.org>
 <20171010075742.GL17578@axis.com>
Message-ID: <20171010091301.GH4031@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-10-17, 09:57, Jesper Nilsson wrote:
> On Fri, Aug 16, 2013 at 04:25:04AM +0200, Viresh Kumar wrote:
> > Most of the drivers do following in their ->target_index() routines:
> > 
> > 	struct cpufreq_freqs freqs;
> > 	freqs.old = old freq...
> > 	freqs.new = new freq...
> > 
> > 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> > 
> > 	/* Change rate here */
> > 
> > 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> > 
> > This is replicated over all cpufreq drivers today and there doesn't exists a
> > good enough reason why this shouldn't be moved to cpufreq core instead.
> > 
> > Earlier patches have added support in cpufreq core to do cpufreq notification on
> > frequency change, this one removes it from this driver.
> > 
> > Some related minor cleanups are also done along with it.
> > 
> 
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

Wow..

You just Acked a 4 years old patch :)

-- 
viresh
