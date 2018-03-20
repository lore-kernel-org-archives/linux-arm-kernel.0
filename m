From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 20 Mar 2018 18:37:48 +0000
Subject: [GIT PULL] firmware: ARM SCMI fixes for v4.17
Message-ID: <20180320183747.GB16362@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

I have based this on the earlier/first SCMI pull request I sent for
v4.17. Couple of build/static checker warnings were reported and also
received a comment from clock maintainer to use new devm_* API. This
PR contains patches addressing those.

Please pull !

Regards,
Sudeep

--

The following changes since commit 02f208c5c60549039445402505dea284e15f0f4f:

  cpufreq: scmi: add support for fast frequency switching (2018-02-28 16:37:57 +0000)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-fixes-4.17

for you to fetch changes up to 7f9badfceffc6d2ae331050f1cd155a633130437:

  clk: scmi: use devm_of_clk_add_hw_provider() API and drop scmi_clocks_remove (2018-03-20 16:23:26 +0000)

----------------------------------------------------------------
ARM SCMI fixes/cleanups for v4.17

Couple of fixes for build warning due to uninitialised variable
and static checker warning for passing NULL pointer to PTR_ERR.
It also contains cleanup suggested by Stephen Boyd in SCMI clock
driver using the new devm_of_clk_add_hw_provider() API.

----------------------------------------------------------------
Anders Roxell (1):
      firmware: arm_scmi: prevent accessing rate_discrete uninitialized

Sudeep Holla (2):
      hwmon: (scmi) return -EINVAL when sensor information is unavailable
      clk: scmi: use devm_of_clk_add_hw_provider() API and drop scmi_clocks_remove

 drivers/clk/clk-scmi.c            | 12 ++----------
 drivers/firmware/arm_scmi/clock.c |  5 +++--
 drivers/hwmon/scmi-hwmon.c        |  2 +-
 3 files changed, 6 insertions(+), 13 deletions(-)
