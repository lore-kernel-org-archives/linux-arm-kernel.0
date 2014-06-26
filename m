From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 26 Jun 2014 16:22:46 +0530
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <53AB1CC1.4010907@codeaurora.org>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
Message-ID: <CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2014 00:32, Stephen Boyd <sboyd@codeaurora.org> wrote:
> I don't think this driver should be using regulator_get_optional() (Mark
> B. please correct me if I'm wrong). I doubt a supply is actually
> optional for CPUs, just some DTs aren't specifying them. In those cases,
> the regulator core will insert a dummy supply and the code will work
> without having to check for probe defer and error pointers.

Hi Stephen,

Thanks for your comments.

Leaving the above one, I have tried to fix all you mentioned. And it surely
looks much better now.

I would like to wait for a day or two before sending V2, as people might
be reviewing it and the above issue is still wide open..

But in case you wanna test it (completely changed I must say, but
for good), its here:

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-krait-v2

Let me know if you still find it childish :)
