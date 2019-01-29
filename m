Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0368C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8131B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ai4x8TAj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xNTcsev8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8131B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wy8W/0lu3k4M33S1iQ16js9TfP3hHgftNxnnRX4P5Lw=; b=Ai4x8TAjIvdSx3
	H4G41XbrDHgn9KR0O++N6OqI5zgVf+xTClM1UrYq7T6xMUgCLPyDB9/bf8Xq+8oOki45YNfFhCQ8J
	VWkw/Whb9LdWr9mNsuairJsf+5RJAKWt/WHdEbn5+5iBdb21ogokTWfkhja3LXYOPlzk71X9F6xLu
	brLDl9f9oLT/QmJtGtojFHIgAqxsYCISb5LLAd/zG4LMZ/BN0GcnZ6IjCgFyYTfwPtNMRIIjkENq/
	J2/1MDiQAFMAV2Wk2YC4HCyuCBU9ymX1kB3rbzbp9MC9OP4k+7DspyOXUa97DgRTf54Lclf6dR6L7
	NASA8gEN07TEH0rVIBQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOW9-0000MQ-5Q; Tue, 29 Jan 2019 08:13:13 +0000
Received: from mail-he1eur01on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::628]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOTI-0005RP-LZ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnYqNNEilZ8rUKOIwLta2v85nEKExuvg5S5VPPFpOj0=;
 b=xNTcsev8uR0+MTkQhtoxdvwMLHzwckrN2JmnhYmqk3q8kbVJyiPoEQ+/Q59bBnnqHS+CmD26NonFkuTa6aFICYCTWUcy8oRM9NlMvIPCECyeWY0VWY+tPVa3rptlb4ubV9cOjKe3J+nWNhHFDeOCnqzb99AU06lt122pz44VLlk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:11 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:11 +0000
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "l.subrahmanya@mobiveil.co.in"
 <l.subrahmanya@mobiveil.co.in>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Subject: [PATCHv3 16/27] PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP
 driver
Thread-Topic: [PATCHv3 16/27] PCI: mobiveil: refactor Mobiveil PCIe Host
 Bridge IP driver
Thread-Index: AQHUt6oOtPM4TbAa1EKhHjXOexvjRA==
Date: Tue, 29 Jan 2019 08:10:11 +0000
Message-ID: <20190129080926.36773-17-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5127;
 6:0A4Ie2ACDUZpjoxo19yZ42qtnHWo5kwDxhT6N3Opo+zAxykE/bl1E6mKRgW8gffOd4ONLZJ4ZSx5UlmaXXm1KgZZoE+MsP5RDD27qjkIJdqp5zdTdHVyKnJW3zbj4XsbpZ+iziYOhMkEpE3jOTxyrjkiB6Iz+7Ztt3vr1X6mj82KfQeZFVkd/qR8ICPvb2pG/1od7ScjQEmH/sBXwjrBmHEk+WieNyU+VUux6F9oFSxPyleAhEfmXLGQ6MeO4nHrpZuECn7BE6gle9DPqfdkBpIjjOo89HOd8Bq2w62Y5bek/wVs83EYvtoE4Yd231aKlHigVlv3zsdvAJ0TrAa0YI3J1ZmSbxhgBpgg9b9olu0HYBj4FTcJEylySc/osiEahHs+lKzhvhpIusesWY717uZlYZDJX9aOF7CYNVZm6DQkNLcAE/fQasJOfMgWE6MePWLDflZx4NNijntRKR7FlA==;
 5:UVIhdp8KtNHDZFRo0cp82VX12XoBB4/p9Mp1X7RTVYqtCGITyn9RDG0xK8r6Mivoos2EOtZgpyK3dF2/rVUHgj4d3o8tR54/6/T6I8MLJIMw//aKhnDshFhdG0WAXAPHa1LdVTzaDvnVTXIfrRdxLTB8POM4REwSwesBEHojDhLVdno6JSrwXoQxXVpND/21jehQUNRLI8obven4iOQplA==;
 7:w4hmyEA7fUP0Ei7xYuYTwxvmD9gt7hhCVcZQ/zLqqjQsGEBqKV6BziUcdF1ZsMkl5Axzj3ug1m+Y+Tk/23DUyXbHDAOcwQNlbjdPrjsXo82Khyo1X3gzVzZsdOMGpYlc+LZtYnf0H+JeaAoHI8ojtw==
x-ms-office365-filtering-correlation-id: 93cf3361-8ef4-4eac-3d34-08d685c13071
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5127; 
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB51271BEF48B271302D5602E284970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(53946003)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(30864003)(5024004)(14444005)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003)(579004)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5127;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vS1CnM6GmbNBNNTwWA+Sr4bDzRA4X+FyltAFNsZVobUykICx7OWK7W6dqXU3j/vBnxc0e4cr+pS/36BI6YQ8GVS7VOkA5ulmNByD+tE2xC7DcaRKt1d1DjsQD3Jd7b6PyiQASJhXJnwXoV+h9FqVT3iUlGNlkgJs1pmsTcMVtb1C24gRGeXo6OodMzurW+v4wbx5M6KxSbIVW7uF/APLB2ULNTEcO9inoSaQnK00KAIyWTw5ZfgMGLvbZNgjnAgRnCwgeF+hhas+W0538AzKGsFnjVmkzhBNGAlBhv6ZVmv7Mw99rML1jawMpKrRyXtuSUFTQEeaQs7Ng6hm4rxr4HRvsp95YE7JzJxyZ8NFBq37mkSkSHiTyvmJtwdoIasVui9NP2V5N5xZjgFLEsUYWtkedK2Vck4LEe8Vw3pSZfg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cf3361-8ef4-4eac-3d34-08d685c13071
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:05.1319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001017_152289_C4FBECF7 
X-CRM114-Status: GOOD (  17.59  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "M.h. Lian" <minghuan.lian@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As the Mobiveil PCIe controller support RC&EP DAUL mode, and to
make platforms which integrated the Mobiveil PCIe IP more easy
to add their drivers, this patch moved the Mobiveil driver to
a new directory 'drivers/pci/controller/mobiveil' and refactored
it according to the abstraction of RC&EP (EP driver will be added
later).

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  24 +
 drivers/pci/controller/mobiveil/Makefile      |   4 +
 .../pcie-mobiveil-host.c}                     | 528 +++---------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 228 ++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 187 +++++++
 9 files changed, 587 insertions(+), 453 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (55%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ddcdc29dfe1f..3bca9642b08b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11709,7 +11709,7 @@ M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/controller/pcie-mobiveil.c
+F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6671946dbf66..0e981ed00a75 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -241,16 +241,6 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
 
-config PCIE_MOBIVEIL
-	bool "Mobiveil AXI PCIe controller"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
-	help
-	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
-	  Soft IP. It has up to 8 outbound and inbound windows
-	  for address translation and it is a PCIe Gen4 IP.
-
 config PCIE_TANGO_SMP8759
 	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
 	depends on ARCH_TANGO && PCI_MSI && OF
@@ -281,4 +271,5 @@ config VMD
 	  module will be called vmd.
 
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/mobiveil/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index d56a507495c5..b79a615041a0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -26,11 +26,11 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
-obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
+obj-y				+= mobiveil/
 
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
new file mode 100644
index 000000000000..64343c07bfed
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Mobiveil PCIe Core Support"
+	depends on PCI
+
+config PCIE_MOBIVEIL
+	bool
+
+config PCIE_MOBIVEIL_HOST
+        bool
+	depends on PCI_MSI_IRQ_DOMAIN
+        select PCIE_MOBIVEIL
+
+config PCIE_MOBIVEIL_PLAT
+	bool "Mobiveil AXI PCIe controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on OF
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
+	  Soft IP. It has up to 8 outbound and inbound windows
+	  for address translation and it is a PCIe Gen4 IP.
+
+endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
new file mode 100644
index 000000000000..9fb6d1c6504d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
+obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
+obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
similarity index 55%
rename from drivers/pci/controller/pcie-mobiveil.c
rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 9210165fe8c0..dc5324d94466 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -4,9 +4,9 @@
  *
  * Copyright (c) 2018 Mobiveil Inc.
  * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
  */
 
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -23,275 +23,21 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "../pci.h"
-
-/* register offsets and bit positions */
-
-/*
- * translation tables are grouped into windows, each window registers are
- * grouped into blocks of 4 or 16 registers each
- */
-#define PAB_REG_BLOCK_SIZE		16
-#define PAB_EXT_REG_BLOCK_SIZE		4
-
-#define PAB_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_REG_BLOCK_SIZE))
-#define PAB_EXT_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
-
-#define LTSSM_STATUS			0x0404
-#define  LTSSM_STATUS_L0_MASK		0x3f
-#define  LTSSM_STATUS_L0		0x2d
-
-#define PAB_CTRL			0x0808
-#define  AMBA_PIO_ENABLE_SHIFT		0
-#define  PEX_PIO_ENABLE_SHIFT		1
-#define  PAGE_SEL_SHIFT			13
-#define  PAGE_SEL_MASK			0x3f
-#define  PAGE_LO_MASK			0x3ff
-#define  PAGE_SEL_OFFSET_SHIFT		10
-
-#define PAB_AXI_PIO_CTRL		0x0840
-#define  APIO_EN_MASK			0xf
-
-#define PAB_PEX_PIO_CTRL		0x08c0
-#define  PIO_ENABLE_SHIFT		0
-
-#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
-#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
-#define  PAB_INTP_INTX_MASK		0x01e0
-#define  PAB_INTP_MSI_MASK		0x8
-
-#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
-#define  WIN_ENABLE_SHIFT		0
-#define  WIN_TYPE_SHIFT			1
-#define  WIN_TYPE_MASK			0x3
-#define  WIN_SIZE_SHIFT			10
-#define  WIN_SIZE_MASK			0x3fffff
-
-#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
-
-#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
-#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
-#define  AXI_WINDOW_ALIGN_MASK		3
-
-#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
-#define  PAB_BUS_SHIFT			24
-#define  PAB_DEVICE_SHIFT		19
-#define  PAB_FUNCTION_SHIFT		16
-
-#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
-#define PAB_INTP_AXI_PIO_CLASS		0x474
-
-#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
-#define  AMAP_CTRL_EN_SHIFT		0
-#define  AMAP_CTRL_TYPE_SHIFT		1
-#define  AMAP_CTRL_TYPE_MASK		3
-
-#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
-#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
-#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
-#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
-#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
-
-/* starting offset of INTX bits in status register */
-#define PAB_INTX_START			5
-
-/* supported number of MSI interrupts */
-#define PCI_NUM_MSI			16
-
-/* MSI registers */
-#define MSI_BASE_LO_OFFSET		0x04
-#define MSI_BASE_HI_OFFSET		0x08
-#define MSI_SIZE_OFFSET			0x0c
-#define MSI_ENABLE_OFFSET		0x14
-#define MSI_STATUS_OFFSET		0x18
-#define MSI_DATA_OFFSET			0x20
-#define MSI_ADDR_L_OFFSET		0x24
-#define MSI_ADDR_H_OFFSET		0x28
-
-/* outbound and inbound window definitions */
-#define WIN_NUM_0			0
-#define WIN_NUM_1			1
-#define CFG_WINDOW_TYPE			0
-#define IO_WINDOW_TYPE			1
-#define MEM_WINDOW_TYPE			2
-#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
-#define MAX_PIO_WINDOWS			8
-
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_MIN			90000
-#define LINK_WAIT_MAX			100000
-
-#define PAGED_ADDR_BNDRY		0xc00
-#define OFFSET_TO_PAGE_ADDR(off)	\
-	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
-#define OFFSET_TO_PAGE_IDX(off)		\
-	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
-
-struct mobiveil_msi {			/* MSI information */
-	struct mutex lock;		/* protect bitmap variable */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	phys_addr_t msi_pages_phys;
-	int num_of_vectors;
-	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
-};
-
-struct mobiveil_pcie {
-	struct platform_device *pdev;
-	struct list_head resources;
-	void __iomem *config_axi_slave_base;	/* endpoint config base */
-	void __iomem *csr_axi_slave_base;	/* root port config base */
-	void __iomem *apb_csr_base;	/* MSI register base */
-	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
-	struct irq_domain *intx_domain;
-	raw_spinlock_t intx_mask_lock;
-	int irq;
-	int apio_wins;
-	int ppio_wins;
-	int ob_wins_configured;		/* configured outbound windows */
-	int ib_wins_configured;		/* configured inbound windows */
-	struct resource *ob_io_res;
-	char root_bus_nr;
-	struct mobiveil_msi msi;
-};
-
-/*
- * mobiveil_pcie_sel_page - routine to access paged register
- *
- * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
- * for this scheme to work extracted higher 6 bits of the offset will be
- * written to pg_sel field of PAB_CTRL register and rest of the lower 10
- * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
- */
-static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
-{
-	u32 val;
-
-	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
-	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
-	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
-
-	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
-}
-
-static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
-{
-	if (off < PAGED_ADDR_BNDRY) {
-		/* For directly accessed registers, clear the pg_sel field */
-		mobiveil_pcie_sel_page(pcie, 0);
-		return pcie->csr_axi_slave_base + off;
-	}
-
-	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
-	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
-}
-
-static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
-{
-	if ((uintptr_t)addr & (size - 1)) {
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	switch (size) {
-	case 4:
-		*val = readl(addr);
-		break;
-	case 2:
-		*val = readw(addr);
-		break;
-	case 1:
-		*val = readb(addr);
-		break;
-	default:
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
-{
-	if ((uintptr_t)addr & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	switch (size) {
-	case 4:
-		writel(val, addr);
-		break;
-	case 2:
-		writew(val, addr);
-		break;
-	case 1:
-		writeb(val, addr);
-		break;
-	default:
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
-{
-	void *addr;
-	u32 val;
-	int ret;
-
-	addr = mobiveil_pcie_comp_addr(pcie, off);
-
-	ret = mobiveil_pcie_read(addr, size, &val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
-
-	return val;
-}
-
-static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
-{
-	void *addr;
-	int ret;
-
-	addr = mobiveil_pcie_comp_addr(pcie, off);
-
-	ret = mobiveil_pcie_write(addr, size, val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
-}
-
-static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
-{
-	return csr_read(pcie, off, 0x4);
-}
-
-static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
-{
-	csr_write(pcie, val, off, 0x4);
-}
-
-static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-{
-	return (csr_readl(pcie, LTSSM_STATUS) &
-		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
-}
+#include "pcie-mobiveil.h"
 
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
 
 	/* Only one device down on each root port */
-	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
 
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
 
 	return true;
@@ -311,7 +57,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 		return NULL;
 
 	/* RC config access */
-	if (bus->number == pcie->root_bus_nr)
+	if (bus->number == pcie->rp.root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
 
 	/*
@@ -326,7 +72,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 
 	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
 
-	return pcie->config_axi_slave_base + where;
+	return pcie->rp.config_axi_slave_base + where;
 }
 
 static struct pci_ops mobiveil_pcie_ops = {
@@ -340,7 +86,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
 	struct device *dev = &pcie->pdev->dev;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
@@ -365,7 +111,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>= PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq = irq_find_mapping(pcie->intx_domain,
+				virq = irq_find_mapping(pcie->rp.intx_domain,
 							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
@@ -428,10 +174,10 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	/* map config resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "config_axi_slave");
-	pcie->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->config_axi_slave_base))
-		return PTR_ERR(pcie->config_axi_slave_base);
-	pcie->ob_io_res = res;
+	pcie->rp.config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->rp.config_axi_slave_base))
+		return PTR_ERR(pcie->rp.config_axi_slave_base);
+	pcie->rp.ob_io_res = res;
 
 	/* map csr resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -441,12 +187,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base = res->start;
 
-	/* map MSI config resource */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
-	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->apb_csr_base))
-		return PTR_ERR(pcie->apb_csr_base);
-
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins = MAX_PIO_WINDOWS;
@@ -454,119 +194,15 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins = MAX_PIO_WINDOWS;
 
-	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
-static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-	u32 value;
-	u64 size64 = ~(size - 1);
-
-	if (win_num >= pcie->ppio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max inbound windows reached !\n");
-		return;
-	}
-
-	value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
-		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	value |= (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64),
-		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
-
-	csr_writel(pcie, lower_32_bits(cpu_addr),
-		   PAB_PEX_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ib_wins_configured++;
-}
-
-/*
- * routine to program the outbound windows
- */
-static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-
-	u32 value;
-	u64 size64 = ~(size - 1);
-
-	if (win_num >= pcie->apio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max outbound windows reached !\n");
-		return;
-	}
-
-	/*
-	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
-	 * to 4 KB in PAB_AXI_AMAP_CTRL register
-	 */
-	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
-		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
-
-	/*
-	 * program AXI window base with appropriate value in
-	 * PAB_AXI_AMAP_AXI_WIN0 register
-	 */
-	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
-		   PAB_AXI_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ob_wins_configured++;
-}
-
-static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
-{
-	int retries;
-
-	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (mobiveil_pcie_link_up(pcie))
-			return 0;
-
-		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
-	}
-
-	dev_err(&pcie->pdev->dev, "link never came up\n");
-
-	return -ETIMEDOUT;
-}
-
 static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 {
 	phys_addr_t msg_addr = pcie->pcie_reg_base;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
-	pcie->msi.num_of_vectors = PCI_NUM_MSI;
+	msi->num_of_vectors = PCI_NUM_MSI;
 	msi->msi_pages_phys = (phys_addr_t)msg_addr;
 
 	writel_relaxed(lower_32_bits(msg_addr),
@@ -604,9 +240,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
 	csr_writel(pcie, pab_ctrl, PAB_CTRL);
 
-	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-		   PAB_INTP_AMBA_MISC_ENB);
-
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
@@ -628,20 +261,24 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	 */
 
 	/* config outbound translation window */
-	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
-			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->rp.ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->rp.ob_io_res));
 
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
-		if (resource_type(win->res) == IORESOURCE_MEM)
+		if (resource_type(win->res) == IORESOURCE_MEM) {
 			type = MEM_WINDOW_TYPE;
-		else if (resource_type(win->res) == IORESOURCE_IO)
+		} else if (resource_type(win->res) == IORESOURCE_IO) {
 			type = IO_WINDOW_TYPE;
-		else
+		} else if (resource_type(win->res) == IORESOURCE_BUS) {
+			pcie->rp.root_bus_nr = win->res->start;
+			continue;
+		} else {
 			continue;
+		}
 
 		/* configure outbound translation window */
 		program_ob_windows(pcie, pcie->ob_wins_configured,
@@ -656,9 +293,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	value |= (PCI_CLASS_BRIDGE_PCI << 16);
 	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
 
-	/* setup MSI hardware registers */
-	mobiveil_pcie_enable_msi(pcie);
-
 	return 0;
 }
 
@@ -671,11 +305,11 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
 
 	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &= ~mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
 
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
@@ -687,11 +321,11 @@ static void mobiveil_unmask_intx_irq(struct irq_data *data)
 
 	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |= mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
 
 static struct irq_chip intx_irq_chip = {
@@ -759,7 +393,7 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
 					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie = domain->host_data;
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 	unsigned long bit;
 
 	WARN_ON(nr_irqs != 1);
@@ -786,7 +420,7 @@ static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_lock(&msi->lock);
 
@@ -807,9 +441,9 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct mobiveil_msi *msi = &pcie->msi;
+	struct mobiveil_msi *msi = &pcie->rp.msi;
 
-	mutex_init(&pcie->msi.lock);
+	mutex_init(&msi->lock);
 	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 						&msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
@@ -836,15 +470,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	int ret;
 
 	/* setup INTx */
-	pcie->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	pcie->rp.intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+						     &intx_domain_ops, pcie);
 
-	if (!pcie->intx_domain) {
+	if (!pcie->rp.intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
 
-	raw_spin_lock_init(&pcie->intx_mask_lock);
+	raw_spin_lock_init(&pcie->rp.intx_mask_lock);
 
 	/* setup MSI */
 	ret = mobiveil_allocate_msi_domains(pcie);
@@ -854,24 +488,58 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
-static int mobiveil_pcie_probe(struct platform_device *pdev)
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct resource *res;
+	int ret;
+
+	if (pcie->rp.ops->interrupt_init)
+		return pcie->rp.ops->interrupt_init(pcie);
+
+	/* map MSI config resource */
+	res = platform_get_resource_byname(pcie->pdev, IORESOURCE_MEM,
+					   "apb_csr");
+	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
+	pcie->rp.irq = platform_get_irq(pcie->pdev, 0);
+	if (pcie->rp.irq <= 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", pcie->rp.irq);
+		return -ENODEV;
+	}
+
+	/* initialize the IRQ domains */
+	ret = mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(pcie->rp.irq,
+					 mobiveil_pcie_isr, pcie);
+
+	/* Enable interrupts */
+	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+		   PAB_INTP_AMBA_MISC_ENB);
+
+	return 0;
+}
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
-	struct mobiveil_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
-	struct device *dev = &pdev->dev;
+	struct device *dev = &pcie->pdev->dev;
 	resource_size_t iobase;
 	int ret;
 
-	/* allocate the PCIe port */
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie = pci_host_bridge_priv(bridge);
-
-	pcie->pdev = pdev;
+	INIT_LIST_HEAD(&pcie->resources);
 
 	ret = mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
@@ -879,7 +547,10 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&pcie->resources);
+	/* allocate the PCIe port */
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
 
 	/* parse the host bridge base addresses from the device tree file */
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
@@ -899,15 +570,12 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* initialize the IRQ domains */
-	ret = mobiveil_pcie_init_irq_domain(pcie);
+	ret = mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Interrupt init failed\n");
 		goto error;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
@@ -916,7 +584,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
-	bridge->busnr = pcie->root_bus_nr;
+	bridge->busnr = pcie->rp.root_bus_nr;
 	bridge->ops = &mobiveil_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
@@ -944,25 +612,3 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	pci_free_resource_list(&pcie->resources);
 	return ret;
 }
-
-static const struct of_device_id mobiveil_pcie_of_match[] = {
-	{.compatible = "mbvl,gpex40-pcie",},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
-
-static struct platform_driver mobiveil_pcie_driver = {
-	.probe = mobiveil_pcie_probe,
-	.driver = {
-		.name = "mobiveil-pcie",
-		.of_match_table = mobiveil_pcie_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-builtin_platform_driver(mobiveil_pcie_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
-MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
new file mode 100644
index 000000000000..216c62f35568
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "pcie-mobiveil.h"
+
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct device *dev = &pdev->dev;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+
+	return mobiveil_pcie_host_probe(pcie);
+}
+
+static const struct of_device_id mobiveil_pcie_of_match[] = {
+	{.compatible = "mbvl,gpex40-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+static struct platform_driver mobiveil_pcie_driver = {
+	.probe = mobiveil_pcie_probe,
+	.driver = {
+		.name = "mobiveil-pcie",
+		.of_match_table = mobiveil_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(mobiveil_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
new file mode 100644
index 000000000000..ee678a60825d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-mobiveil.h"
+
+/*
+ * mobiveil_pcie_sel_page - routine to access paged register
+ *
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
+{
+	u32 val;
+
+	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
+
+	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
+}
+
+static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
+{
+	if (off < PAGED_ADDR_BNDRY) {
+		/* For directly accessed registers, clear the pg_sel field */
+		mobiveil_pcie_sel_page(pcie, 0);
+		return pcie->csr_axi_slave_base + off;
+	}
+
+	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
+	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
+}
+
+static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
+{
+	if ((uintptr_t)addr & (size - 1)) {
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val = readl(addr);
+		break;
+	case 2:
+		*val = readw(addr);
+		break;
+	case 1:
+		*val = readb(addr);
+		break;
+	default:
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
+{
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	switch (size) {
+	case 4:
+		writel(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	case 1:
+		writeb(val, addr);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+{
+	void *addr;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
+{
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
+	return (csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
+}
+
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 = ~(size - 1);
+
+	if (win_num >= pcie->ppio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max inbound windows reached !\n");
+		return;
+	}
+
+	value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
+		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	value |= (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64),
+		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
+
+	csr_writel(pcie, lower_32_bits(cpu_addr),
+		   PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ib_wins_configured++;
+}
+
+/*
+ * routine to program the outbound windows
+ */
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size)
+{
+
+	u32 value;
+	u64 size64 = ~(size - 1);
+
+	if (win_num >= pcie->apio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max outbound windows reached !\n");
+		return;
+	}
+
+	/*
+	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL register
+	 */
+	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
+		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/*
+	 * program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0 register
+	 */
+	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
+		   PAB_AXI_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ob_wins_configured++;
+}
+
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (mobiveil_pcie_link_up(pcie))
+			return 0;
+
+		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
+	}
+
+	dev_err(&pcie->pdev->dev, "link never came up\n");
+
+	return -ETIMEDOUT;
+}
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
new file mode 100644
index 000000000000..eb4cb61291a8
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#ifndef _PCIE_MOBIVEIL_H
+#define _PCIE_MOBIVEIL_H
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include "../../pci.h"
+
+/* register offsets and bit positions */
+
+/*
+ * translation tables are grouped into windows, each window registers are
+ * grouped into blocks of 4 or 16 registers each
+ */
+#define PAB_REG_BLOCK_SIZE		16
+#define PAB_EXT_REG_BLOCK_SIZE		4
+
+#define PAB_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_REG_BLOCK_SIZE))
+#define PAB_EXT_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
+
+#define LTSSM_STATUS			0x0404
+#define  LTSSM_STATUS_L0_MASK		0x3f
+#define  LTSSM_STATUS_L0		0x2d
+
+#define PAB_CTRL			0x0808
+#define  AMBA_PIO_ENABLE_SHIFT		0
+#define  PEX_PIO_ENABLE_SHIFT		1
+#define  PAGE_SEL_SHIFT			13
+#define  PAGE_SEL_MASK			0x3f
+#define  PAGE_LO_MASK			0x3ff
+#define  PAGE_SEL_OFFSET_SHIFT		10
+
+#define PAB_AXI_PIO_CTRL		0x0840
+#define  APIO_EN_MASK			0xf
+
+#define PAB_PEX_PIO_CTRL		0x08c0
+#define  PIO_ENABLE_SHIFT		0
+
+#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
+#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
+#define  PAB_INTP_INTX_MASK		0x01e0
+#define  PAB_INTP_MSI_MASK		0x8
+
+#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
+#define  WIN_ENABLE_SHIFT		0
+#define  WIN_TYPE_SHIFT			1
+#define  WIN_TYPE_MASK			0x3
+#define  WIN_SIZE_SHIFT			10
+#define  WIN_SIZE_MASK			0x3fffff
+
+#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
+
+#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
+#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
+#define  AXI_WINDOW_ALIGN_MASK		3
+
+#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
+#define  PAB_BUS_SHIFT			24
+#define  PAB_DEVICE_SHIFT		19
+#define  PAB_FUNCTION_SHIFT		16
+
+#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
+#define PAB_INTP_AXI_PIO_CLASS		0x474
+
+#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
+#define  AMAP_CTRL_EN_SHIFT		0
+#define  AMAP_CTRL_TYPE_SHIFT		1
+#define  AMAP_CTRL_TYPE_MASK		3
+
+#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
+#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
+#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
+#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
+#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
+
+/* starting offset of INTX bits in status register */
+#define PAB_INTX_START			5
+
+/* supported number of MSI interrupts */
+#define PCI_NUM_MSI			16
+
+/* MSI registers */
+#define MSI_BASE_LO_OFFSET		0x04
+#define MSI_BASE_HI_OFFSET		0x08
+#define MSI_SIZE_OFFSET			0x0c
+#define MSI_ENABLE_OFFSET		0x14
+#define MSI_STATUS_OFFSET		0x18
+#define MSI_DATA_OFFSET			0x20
+#define MSI_ADDR_L_OFFSET		0x24
+#define MSI_ADDR_H_OFFSET		0x28
+
+/* outbound and inbound window definitions */
+#define WIN_NUM_0			0
+#define WIN_NUM_1			1
+#define CFG_WINDOW_TYPE			0
+#define IO_WINDOW_TYPE			1
+#define MEM_WINDOW_TYPE			2
+#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
+#define MAX_PIO_WINDOWS			8
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_MIN			90000
+#define LINK_WAIT_MAX			100000
+
+#define PAGED_ADDR_BNDRY		0xc00
+#define OFFSET_TO_PAGE_ADDR(off)	\
+	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
+#define OFFSET_TO_PAGE_IDX(off)		\
+	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
+
+struct mobiveil_pcie;
+
+struct mobiveil_msi {			/* MSI information */
+	struct mutex lock;		/* protect bitmap variable */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	phys_addr_t msi_pages_phys;
+	int num_of_vectors;
+	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
+};
+
+struct mobiveil_rp_ops {
+	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+};
+
+struct root_port {
+	u8 root_bus_nr;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	struct resource *ob_io_res;
+	struct mobiveil_rp_ops *ops;
+	int irq;
+	raw_spinlock_t intx_mask_lock;
+	struct irq_domain *intx_domain;
+	struct mobiveil_msi msi;
+};
+
+struct mobiveil_pab_ops {
+	int (*link_up)(struct mobiveil_pcie *pcie);
+};
+
+struct mobiveil_pcie {
+	struct platform_device *pdev;
+	struct list_head resources;
+	void __iomem *csr_axi_slave_base;	/* PAB registers base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
+	void __iomem *apb_csr_base;	/* MSI register base */
+	u32 apio_wins;
+	u32 ppio_wins;
+	u32 ob_wins_configured;		/* configured outbound windows */
+	u32 ib_wins_configured;		/* configured inbound windows */
+	const struct mobiveil_pab_ops *ops;
+	struct root_port rp;
+};
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size);
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size);
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
+
+static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x4);
+}
+
+static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
+{
+	csr_write(pcie, val, off, 0x4);
+}
+
+#endif /* _PCIE_MOBIVEIL_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
