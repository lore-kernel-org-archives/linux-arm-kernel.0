From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 11:35:55 -0700
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex
 A9
In-Reply-To: <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <50FEDC0B.7050604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 10:52 PM, Hiroshi Doyu wrote:
> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.

Will, is your for-next/perf branch stable; can I pull it into a branch
destined for arm-soc? Background below:

Uggh.

This patch (2/2) depends on "ARM: tegra: Use DT /cpu node to detect
number of CPU core" from your Tegra114 series, since that patch removes
the other use of scu_base, thus allowing this patch to remove that variable.

Then, that patch depends on "ARM: Define CPU part numbers and
implementors" from Will Deacon's ARM perf tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf

That means that in order to put this series into arm-soc, we would have
to pull in Will's perf branch first, then the following Tegra patches,
the latter two of which are already in Tegra's for-next, so I'd have to
pull them out:

0bb7bd9 ARM: tegra: Use DT /cpu node to detect number of CPU core
a8f5f25 ARM: tegra: Add CPU nodes to Tegra30 device tree
9975516 ARM: tegra: Add CPU nodes to Tegra20 device tree

Hiroshi, it would be extremely useful if you could explicitly specify
the dependencies of your series when posting them; it took me a long
time and a lot of searching to track all the dependencies down. :-(
