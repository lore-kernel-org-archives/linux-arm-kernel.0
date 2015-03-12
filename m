From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Mar 2015 14:58:55 +0530
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <20150311124555.GB28806@sirena.org.uk>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
 <20150311124555.GB28806@sirena.org.uk>
Message-ID: <CAKohpok=8vU6Nr21n49MHoyk=REEMkuibVk9L+0L7uLnFj==AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 18:15, Mark Brown <broonie@kernel.org> wrote:
> Ugh, no - that's a hideous bodge which is only going to create trouble
> later.  Remember, DT is an ABI and should describe the hardware so if
> we're doing bodges that are visible there to shoehorn things onto our
> implementation that's bad.  The concerns that Pi-Cheng had about what
> happens if the PMIC gets changed definitely seem relevant here too.

Hmm..

> Why not just write a custom cpufreq driver if it's too hard to abstract?

Hmm, probably all that can be solved with the new OPP bindings where
we can have support for multiple regulator or clock sources to the CPU.

@Pi-cheng: How are you going to pass voltages for both the regulators
as OPPs today only support a single regulator, in case you have to write
your own driver.
