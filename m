From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Jun 2017 09:25:33 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
Message-ID: <20170630035533.GV29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-06-17, 11:33, Chen-Yu Tsai wrote:
> AFAIK regulator constraints are supposed to satisfy all users of it.

Right.

> >> >Let me try with an example. A regulator is shared between LCD and DMA
> >> >controller.
> >> >
> >> >Operable ranges of the regulator: 1.8 - 3.0 V
> >> >Range required by LCD: 2.0 - 3.0 V
> >> >Range required by DMA: 1.8 - 2.5 V
> 
> So for the example here, the regulator constraint should be 2.5 - 3.0 V,
> or the intersection of all voltage requirements.

Had a look at regulator_check_consumers() and the range selected by it
is the *highest* min_uV and *lowest* max_uV, to find that intersection
point.

For LCD: min_uV = 2.0 V, max_uV = 3.0 V
For DMA: min_uV = 1.8 V, max_uV = 2.5 V

Highest min_uV = 2.0 V
Lowest max_uV = 2.5 V

And so I mentioned the regulator's final range (that satisfies all
consumers) is 2 - 2.5 V.

Why do you say it should be 2.5 - 3.0 V ?

-- 
viresh
