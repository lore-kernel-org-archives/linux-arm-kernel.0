From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 28 Oct 2014 15:38:06 +0100
Subject: [PATCH 0/4] PM / Domains: Handle errors from ->attach_dev() callback
Message-ID: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enabled the recently added ->attach_dev() callback to return an
error code.

Typically these callbacks will fetch some PM resourses, like clocks through a
clk_get() which may fail. To be able to handle the errors we need to return an
error code.

Do note, the buses which invokes dev_pm_domain_attach() are already handling
-EPROBE_DEFER, which means the ->attach_dev() callbacks may also return this
if needed.


Ulf Hansson (4):
  PM / Domains: Remove reference counting for the generic_pm_domain_data
  PM / Domains: Don't allow an existing generic PM domain data
  PM / Domains: Improve error handling while adding/removing devices
  PM / Domains: Let the ->attach_dev() callback return an error code

 drivers/base/power/domain.c | 143 +++++++++++++++++++++++---------------------
 include/linux/pm_domain.h   |   3 +-
 2 files changed, 77 insertions(+), 69 deletions(-)

-- 
1.9.1
