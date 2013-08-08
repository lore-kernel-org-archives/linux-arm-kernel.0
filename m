From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Aug 2013 08:12:48 +0530
Subject: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
In-Reply-To: <52029713.5070808@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
 <52028620.6000608@wwwdotorg.org>
 <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com>
 <52028859.20008@wwwdotorg.org>
 <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com>
 <52029713.5070808@wwwdotorg.org>
Message-ID: <CAKohpoky9-E2XoxAQy_oQ3sMxvAv5ZfBdDQPd6zUxcSwyKmzXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 00:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Right, and that's *exactly* what having a cpufreq driver is for; to
> implement the details of CPU clock management.

cpufreq drivers used to keep such information since a long time,
probably because there wasn't another place to keep them and
provide generic API's (like generic clock framework).. And so this
replication started to get in place which we are trying to get rid of
now.

All cpufreq drivers share a lot of common code which can go
away and so cpufreq-cpu0 was introduced..

With this patchset this replication goes away for tegra atleast at
the cost of a platform specific clk-cpu driver.. I think that's a good
deal, isn't it?

And that's the only way you can use these generic drivers that we
have...
