From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 Aug 2013 08:49:18 +0530
Subject: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
In-Reply-To: <5203E874.7070907@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
 <52028620.6000608@wwwdotorg.org>
 <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com>
 <52028859.20008@wwwdotorg.org>
 <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com>
 <52029713.5070808@wwwdotorg.org>
 <CAKohpoky9-E2XoxAQy_oQ3sMxvAv5ZfBdDQPd6zUxcSwyKmzXg@mail.gmail.com>
 <5203E874.7070907@wwwdotorg.org>
Message-ID: <CAKohpomaCVLdJoMDhTcRkELvkE6UrtFjN4W7STf=MgYR8sxj4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2013 00:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
> I don't think so. I think it's reasonable to have a per-SoC cpufreq
> driver whose primary content is the parameterization data and/or custom
> hooks for a unified core cpufreq driver. The duplicate parts of each
> cpufreq driver can be moved into the core cpufreq driver, but the
> non-duplicate parts remain. That's how many other subsystems work (MMC,
> USB, ASoC spring to mind).

Guys in the --to list:

Please shout before its too late...

I can understand why Stephen is asking not to implement a virtual clock
driver for cpu as there is no clock corresponding to that.. We are just playing
with existing clocks there..

But I thought these clock APIs can be considered as hooks that we were
looking for and so shouldn't be a problem..

But yes, different people see things differently..

So, if I take Stephen's suggestions then I need to implement hooks into
cpufreq-cpu0 driver for taking freq-table/ setting clk rates, etc...

Let me know if anybody has a issue with that before we actually implement
that..

--
viresh
