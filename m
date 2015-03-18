From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Mar 2015 12:29:43 +0530
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CALx668U7EoiMB8D0Num5w9oC0zZkC55uKaSOLrrBhKnLXUtoOQ@mail.gmail.com>
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
 <CAKohpok=8vU6Nr21n49MHoyk=REEMkuibVk9L+0L7uLnFj==AQ@mail.gmail.com>
 <CALx668U7EoiMB8D0Num5w9oC0zZkC55uKaSOLrrBhKnLXUtoOQ@mail.gmail.com>
Message-ID: <CAKohpon8kXzfeKUUwrRhuei0cY9iVbMHfBjDwXW=M2SAYHdtYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2015 at 16:45, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> The voltages of the two regulators need to be always under a limitation:
> 100mV < Vsram - Vproc < 200mV
> For now, I just calculate the OPPs of Vsram from OPPs of Vproc.
>
> Another thing I should mention, if the voltage difference of two adjacent
> OPPs is greater than 100mV, we need to set the regulator to some
> voltages which are not in OPP table considering the limitation above.
> I think that will make it more difficult to model such flow in a generic
> framework.

Actually the problem is that OPP tables are insufficient for such cases,
and we are adding work-arounds to fix that. Though it will get fixed
with the new bindings we are adding.

I am confused on what we should be doing here. Even if you write
your own driver, you will be abusing DT with incorrect information.

Even if you go around adding a new driver, I would like you to fallback
to cpufreq-dt ones the new OPP bindings are in place.
