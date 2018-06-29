From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 29 Jun 2018 13:04:29 +0200
Subject: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
Message-ID: <20180629110432.5179-1-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently we added support to manage multiple PM domains per device. Consumer
drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
device with one of its PM domain, by using an index.

Let's extend this to allow the association to be done using a name based
lookup, which follows the similar concept as for other resource types, such as
clocks for example.

Ulf Hansson (3):
  PM / Domains: dt: Add a power-domain-names property
  PM / Domains: Introduce option to attach a device by name to genpd
  PM / Domains: Introduce dev_pm_domain_attach_by_name()

 .../bindings/power/power_domain.txt           |  8 +++++++
 drivers/base/power/common.c                   | 17 +++++++++++++
 drivers/base/power/domain.c                   | 24 +++++++++++++++++++
 include/linux/pm_domain.h                     | 15 ++++++++++++
 4 files changed, 64 insertions(+)

-- 
2.17.1
