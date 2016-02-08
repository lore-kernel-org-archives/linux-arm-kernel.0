From: dhdang@apm.com (Duc Dang)
Date: Mon,  8 Feb 2016 14:04:06 -0800
Subject: [PATCH v5 0/3] mailbox: Add APM X-Gene platform mailbox driver
In-Reply-To: <CABb+yY1cE152ZdfK_aeB8ufG=WfoUVB6BN8kXPphYgMBnpH-GA@mail.gmail.com>
References: <CABb+yY1cE152ZdfK_aeB8ufG=WfoUVB6BN8kXPphYgMBnpH-GA@mail.gmail.com>
Message-ID: <cover.1454967957.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APM X-Gene SoC has a mailbox controller that provides
communication mechanism for X-Gene Arm64 cores to communicate
with X-Gene SoC's Cortex M3 (SLIMpro) processor.

X-Gene mailbox controller provides 8 mailbox channels, with
each channel has a dedicated interrupt line.

Changes since v4:
        - Rebase over v4.5-rc1
        - Fix section mismatch warning during compiling
	- Correctly print channel number when there is
	no IRQ for that channel
        - Change node name to mailbox at 10540000
        - Correct the number of IRQs in documentation

Changes since v3:
        - Rebase over v4.4
        - Remove 'id' in slimpro_mbox_chan structure
        - Remove functions that are only called once
        and fold them into the other callers
        - Remove void* pointer type cast
        - Relax the number of mailbox IRQs condition
        - Fix error and address comment in documentation
        (xgene-slimpro-mailbox.txt)

Changes since v2:
        - Rebase Feng's patch set over v4.3-rc5
        - Remove uneccessary 'inline' in function definition
        - Use module_platform_driver instead of subsys_initcall
        - Minor coding stype clean up

Changes since v1:
        - Add ACPI support
        - Use defines for reg offset

Duc Dang (3):
  mailbox: Add support for APM X-Gene platform mailbox driver
  Documentation: mailbox: Add APM X-Gene SLIMpro mailbox dts
    documentation
  arm64: dts: mailbox device tree node for APM X-Gene platform.

 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  35 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  14 ++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-xgene-slimpro.c            | 264 +++++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

-- 
1.9.1
