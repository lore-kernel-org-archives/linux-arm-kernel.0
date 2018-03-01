From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu,  1 Mar 2018 14:58:04 +0100
Subject: [PATCH v2 0/2] STM32 Extended TrustZone Protection driver
Message-ID: <20180301135806.19982-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
to a secure OS running in TrustZone.
We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
because read/write accesses could generate illegale access exceptions.

Extended TrustZone Protection driver make sure that device is disabled if
non-secure world can't acces to it.

version 2:
- do not use notifier anymore
- change status property value in device-tree if needed
- use a list of phandle instead of hard coded array

NOTE: Those patches should be applied only on
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
until this patch: https://lkml.org/lkml/2018/2/26/386
find it way to mainline because KBuild will complain about them.

Benjamin Gaignard (2):
  dt-bindings: stm32: Add bindings for Extended TrustZone Protection
  ARM: mach-stm32: Add Extended TrustZone Protection driver

 .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  25 +++++
 arch/arm/mach-stm32/Kconfig                        |   7 ++
 arch/arm/mach-stm32/Makefile                       |   1 +
 arch/arm/mach-stm32/stm32-etzpc.c                  | 116 +++++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
 create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c

-- 
2.15.0
