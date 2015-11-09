From: dhdang@apm.com (Duc Dang)
Date: Mon,  9 Nov 2015 10:05:42 -0800
Subject: [PATCH v3 0/3] mailbox: Add APM X-Gene platform mailbox driver
In-Reply-To: <1429863912.2927.43.camel@x220>
References: <1429863912.2927.43.camel@x220>
Message-ID: <cover.1447091625.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APM X-Gene SoC has a mailbox controller that provides
communication mechanism for X-Gene Arm64 cores to communicate
with X-Gene SoC's Cortex M3 (SLIMpro) processor.

X-Gene mailbox controller provides 8 mailbox channels, with
each channel has a dedicated interrupt line.

Changes since v2:
        - Rebase Feng's patch set over v4.3-rc5
        - Remove uneccessary 'inline' in function definition
	- Use module_platform_driver instead of subsys_initcall
        - Minor coding stype clean up

Changes since v1:
        - Add ACPI support
        - Use defines for reg offset

 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  34 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  14 ++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-xgene-slimpro.c            | 264 +++++++++++++++++++++
 5 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

-- 
1.9.1
