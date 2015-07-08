From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 8 Jul 2015 16:42:59 +0530
Subject: [PATCH v2 0/9] cpufreq: Introduce support for ST's cpufreq
 functionality
In-Reply-To: <20150708105958.GO3182@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <20150708105054.GB1805@linux> <20150708105958.GO3182@x1>
Message-ID: <20150708111259.GC1805@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-07-15, 11:59, Lee Jones wrote:
> No problem.  So long as it's still on your radar.

So, for the first 7 patches:

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

but for the last two:
- I thought we agreed that you will have a look at opp-v2 bindings and
  create your new bindings as an extension of those ? As we support
  extending opp-v2 bindings per vendor basis.
- And I don't really think you need to create a device for your STM
  driver, why not move your stm-cpufreq file to arch/arm/- and call it
  from .init_late, from where you call init_cpufreq() today. Your
  driver doesn't have anything related to cpufreq-core really and
  isn't required to stay in drivers/cpufreq, unless you want it that
  way.

I haven't reviewed the driver yet and waiting for an answer to opp-v2
question I asked above. opp-v2 is created because we didn't wanted
platforms to create new separate bindings for OPPs :)

-- 
viresh
