From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  2 Sep 2015 01:02:15 +0530
Subject: [RFC 0/3] mmc: sdhci: pass signal voltage as an argument to
 ->voltage_switch()
Message-ID: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to do particular voltage specific configuration in
sdhci_ops->voltage_switch() callback function, we need to
pass respective voltage value as well.

So this patch series pass signal voltage to the controller
specific ->voltage_switch() callback.
Adds controller specific configuration for other voltages as well,
and add implementation for ->voltage_switch to pxav3 driver.


Note:
Currently ->voltage_switch() callback is only supported
in f_sdh30 driver. And I am not sure on the dependency of execution
sequence for that device. I could have moved ->voltage_switch() call
at one common place (above/below), but was not quite sure about it.
So, replicated/duplicated the call for other voltages.


Vaibhav Hiremath (3):
  mmc: sdhci: pass signal_voltage as an argument to voltage_switch
    callback
  mmc: sdhci: add host_ops->voltage_switch callback for all other
    voltages
  mmc: sdhci-pxav3: Add ->voltage_switch callback support

 drivers/mmc/host/sdhci-pxav3.c   | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c         | 10 ++++++-
 drivers/mmc/host/sdhci.h         |  2 +-
 drivers/mmc/host/sdhci_f_sdh30.c |  3 +-
 4 files changed, 71 insertions(+), 3 deletions(-)

-- 
1.9.1
