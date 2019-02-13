Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B68218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HhbwPo12";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4wjwtPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B68218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L32o7yu/FWbK0dmCp8Zk8o+zfBoUhJOQw3hiU60jr8c=; b=HhbwPo12XeCQwK
	X/EHCt63RSVo0/cqyaqQGHZmxJYGN+W5G5AUDROtpUqVlCr0t/u4XL8RWsMjy9PyJSWNZzG4k3oiP
	x8ml04cUC3U9DGA0DO6w9PLAvxArt4wOHOlZJ+ju4tHXN4XttR5eOMa3xyYTrQnd4SZxAuaMErE+L
	3NJMZd19564bZvUa6bVYTPiXTZYxXxR7fdXM6fCQC6tGUifb8zUuz41lukmuMzEBAe39rh10Kr98X
	YO48o5NwD5rHi2rJg1wJTYwAm3pUSJt9sjWc4239tJS+WVz4STX4AsTe1BWCYzX08e30EknoK9PMf
	2URKLOaNbjwGY3SdJcFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtkvf-0005EW-68; Wed, 13 Feb 2019 03:09:43 +0000
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtkvO-0004zJ-Nq
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESTAN2xODOVRrMPO0gHEyfekXMIGo93RGB9zhn3yZwc=;
 b=l4wjwtPQaDIAWtW3zKWzNdKGX7NarNVrsLbELD5Ta9gbX1tafPUdqn1WA4SJcSe8onvk0r7v3G9r1dumvQmEhgqPDmkmOPnjV70y+PUF8yq9FVlDk3sg95tTIgxIIUlZltQ2LWYF/b+bhopvavF4wSKiVNaCdJdX15N/GyogCnM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 03:09:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 03:09:15 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Aisheng Dong
 <aisheng.dong@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross
 <andy.gross@linaro.org>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sntech.de>,
 "arnd@arndb.de" <arnd@arndb.de>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "enric.balletbo@collabora.com"
 <enric.balletbo@collabora.com>, "marc.w.gonzalez@free.fr"
 <marc.w.gonzalez@free.fr>, "olof@lixom.net" <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Topic: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Index: AQHUw0mAk7D4InMTwEi38x/B8uOIAw==
Date: Wed, 13 Feb 2019 03:09:15 +0000
Message-ID: <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3724;
 6:AoEyeCor673jgWKrFPJoIPWzaF59eOY8c0d+waDbGboqphftwrUN87TzpZI8PjjDq4Bd8G8RzjUC5esKwT1ofEwPBBEs+LON5RbBoU7z5IxQTOqvIfPOZ0Abdp2psfqq6dAGy2SgDLzCZ+3JpQfNq2qsF0Vci3Uy7xkgIlwegjQXHz09XyP1xouvRbL2EmcLHo2uAoiyTCv4PhYQ2vWIxDSTK7bag8ww6nkhRo8Pi/YU7AfWO6xHD5Gsefsu/qW5Ru9TIpMi+rGzAwEAONP8H3macsbxfB9FDdUyoY1fq5XJRLFekeDRVcEkG272KTFNDLYIlmfZDYgtPgcpimg0glZ05D5WSvMEjh8oLgCdy6Gd0f8TXy9rJUys5aZ0EuOwMSw52FHL6DXuOef80gvqzs9rQWhUctMyduPTHnikB/yC7OABPzMIPt7CHB6qbh6zSp646Sit3rbrFpsCEIpxfw==;
 5:YF6A17F3y1+0FDbZ+c0Sp1Pwk3iUyRY7nkqH+mxRjPcGS4xZ0gRGiiMJidlAoutWY7m/6bNil7hPaEIrMpm6LThK7XtgIb/FxmXrXcBwBneCF9aAifM6mfB6ABxPTthGzosMAgYCDGCjPeE4cB09IRfEQDRWcMvtZoPBTNGDdFGd98f6GCvg3HHp/LTYNkfzC1Lj22UEtJqCpGvzC+9rdA==;
 7:Yp3WaPRa48bUqGWgznMteLy4qFXk9jkY0CIgVjjFuKhFusbibkkVbUJi/09XOpPuszEuBpQfznaYM94iQabEacNmoLRVMwf8IvqeCaBsDVYr3KiZshRfZvKtc4S2131+qMRhNjqYQB8aQ0kF4TfHiw==
x-ms-office365-filtering-correlation-id: 5fd999be-9608-4a72-f87f-08d69160a29d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3724; 
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB37241E93573DDFC90E1D749BF5660@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(50226002)(97736004)(81166006)(81156014)(8676002)(7736002)(110136005)(446003)(305945005)(2906002)(256004)(52116002)(8936002)(476003)(486006)(2616005)(99286004)(11346002)(3846002)(14444005)(7416002)(6116002)(71200400001)(71190400001)(86362001)(36756003)(26005)(53936002)(478600001)(68736007)(386003)(2501003)(14454004)(186003)(102836004)(6506007)(2201001)(76176011)(316002)(66066001)(4326008)(105586002)(6512007)(106356001)(25786009)(6486002)(6436002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3724;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Adlm22p5rshd/trynX8g4zOyTtQfA3hx7V8+zj6wf9NQtmyxuhdDY4XWl8PEs3kN/5JlQmJxH/ktft9CdpqUW4GFpD3xRGQG8SVDqPGfwOXnyJPNLknLuLQAl6gFpG8vmnc2gbVFGH/cfats3ZeApzm1Dg2T+bu0+JW0wHUxLExu3D988RHNTrSnBF+8h2qxOd7xpRq+7j1az/A4NMM7YiLAIxMeVlfRQBIz9v4fb2N1s/Yeu2d1puJgIh8UP3OscINLYxFL45rEfVN7GaYyexVmmtSvdLPFj/EOUd7KHl8vv+HWqtJuQvispo4Pzm8rUp0al9ffgPJNJ56MCuc+Vwy8D8dukXuvfZ1SQ/AJ+q7DWG55t12DqjWyRyPuMhEU1BpHqmppUZ5V1TG9Grwrj5O89/GCaibdTAc2bqOuwl0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd999be-9608-4a72-f87f-08d69160a29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 03:09:07.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_190927_324430_9F91D544 
X-CRM114-Status: GOOD (  19.21  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux cpufreq driver has
to call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller cpufreq driver support,
when doing CPU frequency scaling, cpufreq driver will do ARM SMC
call and trap to ARM-Trusted-Firmware, then SIP(silicon provider)
service will communicate with system controller for CPU frequenct
scaling.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/Kconfig.arm      |   9 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/imx-sc-cpufreq.c | 183 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/cpufreq/imx-sc-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d3..6d76465 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -92,6 +92,15 @@ config ARM_IMX6Q_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_IMX_SC_CPUFREQ
+	tristate "NXP i.MX SoC system controller cpufreq support"
+	select PM_OPP
+	help
+	  This adds cpufreq driver support for NXP i.MX series SoCs with system
+	  controller inside.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c..28ab9fb 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX_SC_CPUFREQ)	+= imx-sc-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
diff --git a/drivers/cpufreq/imx-sc-cpufreq.c b/drivers/cpufreq/imx-sc-cpufreq.c
new file mode 100644
index 0000000..dfc89abe
--- /dev/null
+++ b/drivers/cpufreq/imx-sc-cpufreq.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/syscalls.h>
+
+#define MAX_CLUSTER		1
+
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
+struct imx_sc_cpufreq {
+	struct device *cpu_dev;
+	struct clk *cpu_clk;
+};
+
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTER];
+static struct imx_sc_cpufreq cluster_freq[MAX_CLUSTER];
+static unsigned int transition_latency[MAX_CLUSTER];
+static DEFINE_SPINLOCK(cpufreq_psci_lock);
+
+static int imx_sc_cpufreq_set_target(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	unsigned int cluster_id = topology_physical_package_id(policy->cpu);
+	unsigned int old_freq, new_freq;
+	struct arm_smccc_res res;
+
+	new_freq = freq_table[cluster_id][index].frequency;
+	old_freq = policy->cur;
+
+	dev_dbg(cluster_freq[cluster_id].cpu_dev, "%u MHz --> %u MHz\n",
+		old_freq / 1000, new_freq / 1000);
+
+	spin_lock(&cpufreq_psci_lock);
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		cluster_id, new_freq * 1000, 0, 0, 0, 0, &res);
+	spin_unlock(&cpufreq_psci_lock);
+
+	return 0;
+}
+
+static int imx_sc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int cluster_id = topology_physical_package_id(policy->cpu);
+	int opp_num, ret = 0;
+
+	policy->clk = cluster_freq[cluster_id].cpu_clk;
+	policy->cur = clk_get_rate(cluster_freq[cluster_id].cpu_clk) / 1000;
+	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+	policy->freq_table = freq_table[cluster_id];
+	policy->cpuinfo.transition_latency = transition_latency[cluster_id];
+	opp_num = dev_pm_opp_get_opp_count(cluster_freq[cluster_id].cpu_dev);
+	policy->suspend_freq = freq_table[cluster_id][opp_num - 1].frequency;
+
+	dev_info(cluster_freq[cluster_id].cpu_dev,
+		"cluster %d running at freq %d MHz, suspend freq %d MHz\n",
+		cluster_id, policy->cur / 1000, policy->suspend_freq / 1000);
+
+	return ret;
+}
+
+static struct cpufreq_driver imx_sc_cpufreq_driver = {
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = imx_sc_cpufreq_set_target,
+	.get = cpufreq_generic_get,
+	.init = imx_sc_cpufreq_init,
+	.name = "imx-sc-cpufreq",
+	.attr = cpufreq_generic_attr,
+#ifdef CONFIG_PM
+	.suspend = cpufreq_generic_suspend,
+#endif
+};
+
+static int imx_sc_cpufreq_probe(struct platform_device *pdev)
+{
+	struct imx_sc_ipc *cpufreq_ipc_handle;
+	struct device *cpu_dev;
+	struct device_node *np;
+	int cluster_id, ret = 0;
+
+	/* wait mailbox driver ready */
+	ret = imx_scu_get_handle(&cpufreq_ipc_handle);
+	if (ret)
+		return ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu device 0\n");
+		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu 0 node\n");
+		return -ENODEV;
+	}
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
+		goto put_node;
+	}
+
+	cluster_id = topology_physical_package_id(0);
+	cluster_freq[cluster_id].cpu_dev = cpu_dev;
+	cluster_freq[cluster_id].cpu_clk = devm_clk_get(cpu_dev, NULL);
+	if (IS_ERR(cluster_freq[cluster_id].cpu_clk)) {
+		dev_err(cpu_dev, "failed to get cluster %d clock\n",
+			cluster_id);
+		ret = -ENOENT;
+		goto put_node;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster_id]);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_opp;
+	}
+
+	if (of_property_read_u32(np, "clock-latency",
+		&transition_latency[cluster_id]))
+		transition_latency[cluster_id] = CPUFREQ_ETERNAL;
+
+	ret = cpufreq_register_driver(&imx_sc_cpufreq_driver);
+	if (ret) {
+		dev_err(cpu_dev, "failed to register cpufreq driver: %d\n",
+			ret);
+		goto free_freq_table;
+	}
+
+	goto put_node;
+
+free_freq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster_id]);
+out_free_opp:
+	dev_pm_opp_of_remove_table(cpu_dev);
+put_node:
+	of_node_put(np);
+	return ret;
+}
+
+static int imx_sc_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&imx_sc_cpufreq_driver);
+
+	return 0;
+}
+
+static int __init imx_sc_register_cpufreq(void)
+{
+	platform_device_register_simple("imx-sc-cpufreq", -1, NULL, 0);
+
+	return 0;
+}
+device_initcall(imx_sc_register_cpufreq);
+
+static struct platform_driver imx_sc_cpufreq_platdrv = {
+	.driver = {
+		.name	= "imx-sc-cpufreq",
+	},
+	.probe		= imx_sc_cpufreq_probe,
+	.remove		= imx_sc_cpufreq_remove,
+};
+module_platform_driver(imx_sc_cpufreq_platdrv);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
