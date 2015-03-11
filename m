From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Mar 2015 17:16:42 +0530
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <1426074142.30734.7.camel@pengutronix.de>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
 <1426074142.30734.7.camel@pengutronix.de>
Message-ID: <CAKohponaQYYgYFAbpY3KZjt4+QhjBsqQtEpG5QpdMH0p__YUEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 17:12, Lucas Stach <l.stach@pengutronix.de> wrote:
> Instead of creating virtual regulators I would be strongly in favor of
> reviving the voltage-domain work. That would allow us to push all those
> voltage dependencies we have seen on various SoCs into the domain
> handling code and don't care about it in the drivers.
>
> In that case cpufreq-dt wouldn't control a regulator directly, but
> request a specific voltage from the domain the CPUs are located in and
> those in turn would control the regulators supplying them.

I agree that it would be the right approach but who is going to do that stuff ?

I think until the time we revive the voltage-domain stuff we need to support
mediatek's driver. And probably a virtual regulator is the best approach
unless someone else comes up with another idea.
