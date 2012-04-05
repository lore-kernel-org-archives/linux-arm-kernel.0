From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 10:41:58 +0530
Subject: [PATCH] clk: Update comment for clk_round_rate()
In-Reply-To: <CAJOA=zOPn0FcwO0McSb8-18h7LiJndRD2nmCCvxUEEm+fakvKg@mail.gmail.com>
References: <CAOh2x=nTSvOrJa2uB2zTvYh1SUO2YpEpnLcL189itJ=_e+MPog@mail.gmail.com>
 <CAJOA=zOPn0FcwO0McSb8-18h7LiJndRD2nmCCvxUEEm+fakvKg@mail.gmail.com>
Message-ID: <4F7D299E.1050307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2012 11:37 PM, Turquette, Mike wrote:
> The common clk framework doesn't enforce any policy like this, nor do
> I think it should.  The clk framework is far from complete and I
> wouldn't be surprised if we see folks who want their rounded rate to
> represent a minimum value (instead of a maximum as your patch states).

Ok. Just for example, suppose foo_clk can have following rates:
100, 110, 120, 130, 140.

And we call round_rate with a value of 126.

Now i can't visualize why would anybody want it to return 130 (above the
limits requested)? I agree both 100 and 120 can be returned, based on
your below logic.

>  This might be achieved later on by a platform-specific or
> framework-wide flag, similar to how CPUfreq does it today
> (CPUFREQ_RELATION_L and CPUFREQ_RELATION_H).
> 

> Thank you for submitting the patch, but for now it's a NACK.

No Probs.

-- 
viresh
