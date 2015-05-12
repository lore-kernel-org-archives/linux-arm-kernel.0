From: mike.turquette@linaro.org (Michael Turquette)
Date: Tue, 12 May 2015 14:47:14 -0700
Subject: [PATCH V4 3/3] OPP: Add 'opp-next' in operating-points-v2 bindings
In-Reply-To: <1ee98ae5b45083e681c7f530e0ae9195e5636119.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <1ee98ae5b45083e681c7f530e0ae9195e5636119.1430394884.git.viresh.kumar@linaro.org>
Message-ID: <20150512214714.16410.59831@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2015-04-30 05:08:01)
> Many platforms require to switch to a intermediate frequency before
> switching to a final frequency. Or they can switch to only particular
> OPPs from any OPP.
> 
> For these add another property in OPP-v2, 'opp-next'.
> 
> Refer to the bindings for more details.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

We should never encode any aspect of the dvfs transition sequence into
DT. Raw data such as clock frequency or supply voltage might be OK, but
the programming steps should be left entirely to drivers.

So this patch gets a NAK from me.

Regards,
Mike
