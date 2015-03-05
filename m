From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 5 Mar 2015 16:32:06 +0530
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305105104.GJ11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
 <CALx668X2m0hMVQumGQmhhrKnv4h1hiYp20Q4FcKuECK3mhoJiA@mail.gmail.com>
 <20150305105104.GJ11010@pengutronix.de>
Message-ID: <CAKohpo=90YH3TLfnMro0AQOM6_uMB_SPS9Q3j6Myz4RqqBdVHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 16:21, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Given the variance of different SoCs I don't think it makes sense
> to try to handle all these cases. Instead the cpufreq-dt driver
> should just call clk_set_rate() on the CPU clock with the desired
> target frequency. Everything else should be handled in the clock
> driver which has intimate knowledge about the SoC anyway.

I agree..

@Russell: I wanted to ask you this since sometime..

On CPU-freq changes we fire PRE/POST notifiers and they are
used for updating loops_per_jiffies which then controls delays.

Now, it is fine to do that for normal frequencies, but what should be
the approach for intermediate frequencies ?

Intermediate freqs: On some platforms changing PLL's straight away
isn't considered safe and so we switch parent to another stable clock,
change PLL rate and switch back.

The *wild* thought I earlier had was to fire these notifiers for even these
intermediate frequencies, otherwise some of the delays will end before
they should have and that *might* cause other problems.

I wanted to know what do you (and other champs) think about this..

Thanks in advance for your advice.
