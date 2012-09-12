From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 11 Sep 2012 20:57:40 -0700
Subject: [PATCH 2/2] ARM: tegra: cpu-tegra: explicitly manage re-parenting
In-Reply-To: <20120912041001.GB3402@S2100-06.ap.freescale.net>
References: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
 <1347318758-7954-2-git-send-email-swarren@wwwdotorg.org>
 <20120911044530.20289.8165@nucleus>
 <20120912041001.GB3402@S2100-06.ap.freescale.net>
Message-ID: <CAJOA=zP5mYLBKGcTzEoJEfNa5WLbdBei0BeN26Qgn=CJyXw=1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 9:10 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Sep 10, 2012 at 09:45:30PM -0700, Mike Turquette wrote:
>> > To solve this, have the Tegra cpufreq driver explicitly perform the
>> > reparenting operations itself. This is probably reasonable anyway,
>> > since such reparenting is somewhat a matter of policy (e.g. which
>> > alternate clock source to use, whether to leave the CPU clock a child
>> > of the alternate clock source if it's running at the desired rate),
>> > and hence is something more appropriate for the cpufreq driver than
>> > the core clock driver anyway.
>> >
>>
>> I definitely agree about the policy.  Just FYI I'm hacking on an RFC to
>> make reparenting clocks from a call to clk_set_rate even easier, but
>> perhaps in your case it is better the cpufreq driver knows the clock
>> tree topology details.
>>
> I disagree.  The whole point of clock framework is to hide clock details
> like tree topology behind clock API, so that we do not need every single
> clock client driver to handle those details on their own.  It's
> definitely desired to have clk_set_rate call handle reparenting nicely.
>
> From what I see, if tegra clock driver can handle the dependency between
> cpu_clk and emc_clk that is currently handled in cpufreq driver.  It's
> likely that the generic cpufreq driver (cpufreq-cpu0) would work for
> tegra.  But with this patch, the driver moves to the opposite direction.
>

Hmm, the cpufreq-cpu0 case is a good point.  Well like I said in my
previous email this can be done in the framework.  I'll try to get an
example of this on the list ASAP but of course my todo list is a fifo
not a stack.

Regards,
Mike

> Regards,
> Shawn
>
