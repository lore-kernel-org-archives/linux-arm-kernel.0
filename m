Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A28A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJwvDye9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e71LPwDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A28A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=I4rRPUJjEPUBH+gLqpoeHbWi+oSwiGe0MfLzzBazEhw=; b=UJwvDye9kpNjSrLyX9cTW/nhw9
	ABzsx8g9XJHVS53T+SGGQ5VOhr/tsUB8vLJy9bZhY4Ymf3sawKiLxSHr8nM7g6MjP3tT2Xu4QQN/2
	ryCMYRQgeC6xWlFRNp+RlT9ze50XhTIgmOCQLM0no8O7jJeToG3VcaVu9ZH6xcm2E+PyyU02V9uGv
	NMplhqcCsP9SJ7Y24qZ+mmqDwzdlcLCTYS+6c62FN0UolBBTkEfIUtNcFaVVE/6XoPAY+2hQ2xGKC
	xiVGMXXokwHsi8FpFRYjgUTACGL2WzzpBFa2g0LWtfcB/wkxYsDb0BDkYNJSM5xPLzMtPSNLbIugA
	a3Pwx0eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXnZ-0004Id-Hg; Tue, 15 Jan 2019 23:07:09 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXnO-00047F-59
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:07:02 +0000
Received: by mail-ed1-x542.google.com with SMTP id a20so3936010edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2tlvHHTliWPEKYE42LEKdctKb5h1abooAbKy1jd2DTU=;
 b=e71LPwDts3xwVnVibDhJ+z1GobKPIutDfRzJzSJM1qHk9lbMS1t/dMEPawM8Y5B7oj
 tZdYWnHPZd/JRpOSaEqi719AO4zIz+dK+FQEnlgySo8J4xPwXfNOVfAzey1MwR4DY+8o
 9ssDKvoeABY1sn68mNHylVriqtf5k3d16Gyd4Zz9yRyiYuJKk1dGxdHG5tTF+EOlkR4b
 17fb9ltNvvif2VRmQR5cVfEF6cZKBMRwMA6cTAPE0gefU/l5FRQuTUbmNajGZi/33nYR
 egGPRSx97Qu6G+XGfQzVmLlBg2G9SawFpBqopStzR/T9k/9fa4PX6OvpDtoIczqmhHg/
 gR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2tlvHHTliWPEKYE42LEKdctKb5h1abooAbKy1jd2DTU=;
 b=T2gBvjiTrGJ/UKCNRoOR5/U8E+2mUKzSHbP/XFgX8EsbFgU5AF5D0YljCNNl7m4S29
 c6MtgJzLYs+skR6kj8EHfHXpEslBw/PFTXAY7oJn5EgEIg3aOk3X/nyPBKdLpEpH2CHB
 MS+9htIEN+wll98F5e6E/IF/0HbPuUjCmb6wtynPW+ld+rJwIx49Nx20Kc4jTW6erGkD
 kemvajCOAO/dJ8eH6dAujtV13Lr5BpA/n45HGn/nYQCSm8BYU6MSLcHgIrNwd7cLuhFv
 oi66NdkAeHbGprNYHSZgWMZOEqyUapybuw6UfX88NZ4E2ct0iH+n4wfKRJq/ASO0CRlD
 R3xA==
X-Gm-Message-State: AJcUukc3dPVafmoFUaxXadROSUuqFiYzbOtTPc8RArupNrxCsfjHatRU
 CCA16ruVWi9t3jyr9qt7A+Q=
X-Google-Smtp-Source: ALg8bN6wGPula9sQ6HSp8FmKuxJHahRGy9mVKZ+/C43mOVaqh/Z+RPCkdmcoQuiymNkwpf2KFM5NHA==
X-Received: by 2002:a50:d643:: with SMTP id c3mr4986590edj.178.1547593616652; 
 Tue, 15 Jan 2019 15:06:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:06:55 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Date: Tue, 15 Jan 2019 15:06:11 -0800
Message-Id: <20190115230613.28334-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_150658_310571_3A0BF2C8 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instead of having net/dsa.h contain both the internal switch tree/driver
structures, split the relevant platform_data parts into
include/linux/platform_data/dsa.h and make that header be included by
net/dsa.h in order not to break any setup. A subsequent set of patches
will update code including net/dsa.h to include only the platform_data
header.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/linux/platform_data/dsa.h | 68 +++++++++++++++++++++++++++++++
 include/net/dsa.h                 | 61 +--------------------------
 3 files changed, 70 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/platform_data/dsa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a592b9992b46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10576,6 +10576,7 @@ F:	Documentation/devicetree/bindings/net/dsa/
 F:	net/dsa/
 F:	include/net/dsa.h
 F:	include/linux/dsa/
+F:	include/linux/platform_data/dsa.h
 F:	drivers/net/dsa/
 
 NETWORKING [GENERAL]
diff --git a/include/linux/platform_data/dsa.h b/include/linux/platform_data/dsa.h
new file mode 100644
index 000000000000..d4d9bf2060a6
--- /dev/null
+++ b/include/linux/platform_data/dsa.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DSA_PDATA_H
+#define __DSA_PDATA_H
+
+struct device;
+struct net_device;
+
+#define DSA_MAX_SWITCHES	4
+#define DSA_MAX_PORTS		12
+#define DSA_RTABLE_NONE		-1
+
+struct dsa_chip_data {
+	/*
+	 * How to access the switch configuration registers.
+	 */
+	struct device	*host_dev;
+	int		sw_addr;
+
+	/*
+	 * Reference to network devices
+	 */
+	struct device	*netdev[DSA_MAX_PORTS];
+
+	/* set to size of eeprom if supported by the switch */
+	int		eeprom_len;
+
+	/* Device tree node pointer for this specific switch chip
+	 * used during switch setup in case additional properties
+	 * and resources needs to be used
+	 */
+	struct device_node *of_node;
+
+	/*
+	 * The names of the switch's ports.  Use "cpu" to
+	 * designate the switch port that the cpu is connected to,
+	 * "dsa" to indicate that this port is a DSA link to
+	 * another switch, NULL to indicate the port is unused,
+	 * or any other string to indicate this is a physical port.
+	 */
+	char		*port_names[DSA_MAX_PORTS];
+	struct device_node *port_dn[DSA_MAX_PORTS];
+
+	/*
+	 * An array of which element [a] indicates which port on this
+	 * switch should be used to send packets to that are destined
+	 * for switch a. Can be NULL if there is only one switch chip.
+	 */
+	s8		rtable[DSA_MAX_SWITCHES];
+};
+
+struct dsa_platform_data {
+	/*
+	 * Reference to a Linux network interface that connects
+	 * to the root switch chip of the tree.
+	 */
+	struct device	*netdev;
+	struct net_device *of_netdev;
+
+	/*
+	 * Info structs describing each of the switch chips
+	 * connected via this network interface.
+	 */
+	int		nr_chips;
+	struct dsa_chip_data	*chip;
+};
+
+
+#endif /* __DSA_PDATA_H */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index b3eefe8e18fd..6178b648d08a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -21,6 +21,7 @@
 #include <linux/ethtool.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
+#include <linux/platform_data/dsa.h>
 #include <net/devlink.h>
 #include <net/switchdev.h>
 
@@ -44,66 +45,6 @@ enum dsa_tag_protocol {
 	DSA_TAG_LAST,		/* MUST BE LAST */
 };
 
-#define DSA_MAX_SWITCHES	4
-#define DSA_MAX_PORTS		12
-
-#define DSA_RTABLE_NONE		-1
-
-struct dsa_chip_data {
-	/*
-	 * How to access the switch configuration registers.
-	 */
-	struct device	*host_dev;
-	int		sw_addr;
-
-	/*
-	 * Reference to network devices
-	 */
-	struct device	*netdev[DSA_MAX_PORTS];
-
-	/* set to size of eeprom if supported by the switch */
-	int		eeprom_len;
-
-	/* Device tree node pointer for this specific switch chip
-	 * used during switch setup in case additional properties
-	 * and resources needs to be used
-	 */
-	struct device_node *of_node;
-
-	/*
-	 * The names of the switch's ports.  Use "cpu" to
-	 * designate the switch port that the cpu is connected to,
-	 * "dsa" to indicate that this port is a DSA link to
-	 * another switch, NULL to indicate the port is unused,
-	 * or any other string to indicate this is a physical port.
-	 */
-	char		*port_names[DSA_MAX_PORTS];
-	struct device_node *port_dn[DSA_MAX_PORTS];
-
-	/*
-	 * An array of which element [a] indicates which port on this
-	 * switch should be used to send packets to that are destined
-	 * for switch a. Can be NULL if there is only one switch chip.
-	 */
-	s8		rtable[DSA_MAX_SWITCHES];
-};
-
-struct dsa_platform_data {
-	/*
-	 * Reference to a Linux network interface that connects
-	 * to the root switch chip of the tree.
-	 */
-	struct device	*netdev;
-	struct net_device *of_netdev;
-
-	/*
-	 * Info structs describing each of the switch chips
-	 * connected via this network interface.
-	 */
-	int		nr_chips;
-	struct dsa_chip_data	*chip;
-};
-
 struct packet_type;
 struct dsa_switch;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
