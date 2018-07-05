From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  5 Jul 2018 10:39:22 +0530
Subject: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Message-ID: <cover.1530766981.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an attempt to fix the broken or partially defined DT bindings
for cooling-maps. We should list every device that participates in
cooling down at a certain trip point, instead of just the first in the
list as that depends on certain ordering of events to work properly.

The first patch extends the binding to allow a list of phandles in
"cooling-device" property and the second patch fixes one of the
platform's DT.

This will be followed up by fixing all platform DT bindings that have
these issues after this set is accepted.

The kernel also requires some changes to handle the phandle list, but
wouldn't break with these changes as it reads the first phandle in the
list for now. We can update that separately.

--
viresh

Viresh Kumar (2):
  dt-bindings: thermal: Allow multiple devices to share cooling map
  arm64: dts: hi6220: Add all CPUs in cooling maps

 Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c
