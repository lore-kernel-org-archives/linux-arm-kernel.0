From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 26 Jun 2014 13:04:35 +0530
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <53AB1CC1.4010907@codeaurora.org>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
Message-ID: <CAKohpokK+2hJ=pbLsjaqE_R3yBKcP-BwmH6RYdNRv69O-4ah8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2014 00:32, Stephen Boyd <sboyd@codeaurora.org> wrote:

>> +     cpu_reg = regulator_get_optional(cpu_dev, "cpu0");

> I don't think this driver should be using regulator_get_optional() (Mark
> B. please correct me if I'm wrong). I doubt a supply is actually
> optional for CPUs, just some DTs aren't specifying them. In those cases,
> the regulator core will insert a dummy supply and the code will work
> without having to check for probe defer and error pointers.

This is what Mark did earlier, don't know if he would like to revert it:
7d74897 (cpufreq: cpufreq-cpu0: Use devm_regulator_get_optional()).
