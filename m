From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Jan 2013 20:11:37 +0530
Subject: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <20130108143554.GC19534@S2101-09.ap.freescale.net>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
 <20130108143554.GC19534@S2101-09.ap.freescale.net>
Message-ID: <CAKohpomQuoUgPVp6e9_UrK0sk+z26cG36DoxH91LWSmBHD36BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2013 20:05, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>> > +{
>> > +       int ret;
>> > +
>> > +       if (policy->cpu != 0)
>> > +               return -EINVAL;
>>
>> Why? The problem here is when you hot-unplug cpu0, init would be called for
>> cpu1 and it would fail.
>>
>
> On imx6q, we can never hot-unplug cpu0.  And all the cores of imx6q
> share the clock and voltage, so have to scale together.  That's why
> we only need to do this init for cpu0.

Ok, in that case too you don't need this code. init() wouldn't be
called for any other
cpu if policy->cpus is set correctly. So, that turns out to be a junk code.
