From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 31 Jul 2015 11:28:06 +0530
Subject: [PATCH V3 07/16] PM / OPP: Add support to parse
 "operating-points-v2" bindings
In-Reply-To: <20150731055106.GJ3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
 <20150731055106.GJ3159@codeaurora.org>
Message-ID: <20150731055806.GN17794@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-07-15, 22:51, Stephen Boyd wrote:
> > +	opp->u_volt = microvolt[0];
> > +	opp->u_volt_min = microvolt[1];
> > +	opp->u_volt_max = microvolt[2];
> 
> Should the default be 0 and ULONG_MAX for volt_min/volt_max when
> there's on element?

I am not still sure how the regulator API is going to look like for
this target/min/max thing. So, lets defer it until that is resolved.
For now they are initialized to 0.

And, because the user has just passed in a target voltage, maybe all
three must be == u_volt. :)

-- 
viresh
