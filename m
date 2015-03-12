From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Mar 2015 14:51:30 +0530
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150311001328.14952.56422@quantum>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
 <CALx668X2m0hMVQumGQmhhrKnv4h1hiYp20Q4FcKuECK3mhoJiA@mail.gmail.com>
 <20150305105104.GJ11010@pengutronix.de>
 <CAKohpo=90YH3TLfnMro0AQOM6_uMB_SPS9Q3j6Myz4RqqBdVHg@mail.gmail.com>
 <20150311001328.14952.56422@quantum>
Message-ID: <CAKohpomZtg583gwWYYAFBrskaRo4oxk33ThDi2=FEGzT_uKVEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 05:43, Mike Turquette <mturquette@linaro.org> wrote:
> Sorry, I am not who you asked for advice but I will chime in anyways ;-)

Always welcome :)

> I really hate this intermediate frequency stuff in cpufreq. As we

I am starting to :)

> Furthermore any intermediate-frequency property in a Devicetree binding
> would suffer the same fate. Trying to neatly encode some weird sequence
> into this generic thing will get very ugly very fast.

Hmm..

> For proof please look at clk-divider.c, clk-gate.c, clk-mux.c or
> clk-composite.c and you'll see the result of the slow accumulation of
> lots and lots of hardware corner cases onto generic code. If I had known
> then what I know now I would not have created those generic clock types
> and I would have tried for an abstraction layer between generic stuff
> (e.g. find the best divider) and the real hardware stuff (write to the
> register). Instead I kept all of it together and now things are super
> ugly.

Yeah.
