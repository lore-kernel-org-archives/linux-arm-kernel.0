From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Mar 2015 08:20:43 +0530
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
Message-ID: <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2015 at 11:19, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> On 5 March 2015 at 17:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> About putting
> those stuff into regulator driver, I think you mean creating a
> "virtual regulator
> device" and put all the voltage controlling complex into the driver, right?
> Maybe it's a good idea in this case, but I am sure if this kind of
> virtual regulator is acceptable.

@Mark: Is this allowed to create virtual regulator for a CPU ?

> And the flexibility might be an issue, since we might
> use different
> PMIC for same SoC on different board.

We can talk about that separately once Mark replies to my query.


> Combining comments and suggestions from you and Sascha[1], I conclude some
> architectural changes are going to be made in the next version:
>
> 1. Use set_rate hook instead of determine_rate in clk driver, and
> switch to intermeidate
>     PLL parent and back to original CPU PLL parent explicitly in set_rate

Lets wait for Russell's answer to the query I posted before making any
progress here.
