Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB30C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8652421916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jzs8SIYz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzsXKtZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8652421916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A84Uydb4k3v/PXnYewbDsd0uJUYz1M3ZHchmaxAB7/M=; b=Jzs8SIYz/2HnoG
	eqn1gro1UhOWR3sMTlftnN7QccOMfNOlmLoABI0K2AWrPbY2Z3kD+FYz2qy00Wq3p3NN+eLqCxs2a
	ODexnOfRqGIo6sqJ0BZ6Tj5uS7T9KOHyB0sL9enUI7VcwYXgpv3UNad2SI8PQkJHHzDtNrp8DEo8+
	kb5ErHAjdVa0d/CAZFF1/1mO31qk0zamLKLJzQ3xQc1wbHkRt68Bz+/sC2OvUmqw2JGnjnG6oZ/or
	urkBZi7pZCLvxSD3tu+3DYnv/ZRMzRwug2ZKSc4b3CapJCM/lHgu7NS1ZbJOWA6yiynDh3YXjur50
	/I1J9b6oWJYpc4XoLnjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru4S-0001dE-84; Fri, 08 Feb 2019 00:31:08 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3O-0007nh-OR
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:08 +0000
Received: by mail-pl1-x644.google.com with SMTP id z8so830191plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m09kF0Fi0NLeeymHfmgKYOPmCDh2G2+L0dXTvpyHyHg=;
 b=dzsXKtZ0Fim3cjwQhLLvhVsXktoKxQsMktcmqYni3Eb5hs57LWi+P24srKZ+7jBAM2
 zwEtFscYjWQnrr6X2pPTJC+0JL+RYcZjDLX/pxS0V/zBCvtEb7Xm9hDlPd08bHlz9iRI
 ul3XmlBi5obDnYGvuDRyl4Lh+z8GVe2/WAn5nSSAvFRN1g15OnXlbfIWmJxtvyNTahxe
 tMW3gtDB7i1bu9fXoXawzDMJmAZNlaWb4upuEgL8kxt957iEFyo7KhacePFngmwcdxtd
 utT+c5sLIqDD3I0jzDKrChOrDl4InwdbDi1zhXVoF97VGI0L3jqhCFo+ulS6qRbZQLlW
 584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m09kF0Fi0NLeeymHfmgKYOPmCDh2G2+L0dXTvpyHyHg=;
 b=npv7g0r/QOZ4BPCjtkv0tuhjaSx5APP7yp7KMN1IXo1K9/Kk+ZQjh7NULl4+x8ZxH5
 Ix/L+vv8wZiw17lUvM3DufSmr4tArb241sw38VfNvdTDvIg80hHPrzgskCP7/hOko7qQ
 XG42Z2fFjSA6cEiG4F9VPeUWe2sPr3sk8iAILUx9SZegxNeIhWeeDHzMA9JyvwgVD8tU
 zvSONOFpMQdMrN92toQWd49Z7R6e8xpJCYqisfhyYU4E6AXdz9n9M8gddttwiz1k7VpT
 uEI86BC4LYSJNIqJ0FRNzGY+5RJDhfxOqaZxeSdafKNuuQqll2GBVdxODswQUbdtIpXC
 h9bg==
X-Gm-Message-State: AHQUAubFWnOP4m1rzbHgz/Dlv17ALNq4hO2M+ZDCaverr2qWoNq8XM4u
 DqD4YHYi+1WT/vzA1xlUsHI=
X-Google-Smtp-Source: AHgI3IZ+9Sw0ETvVXWytwkQXKXlNz+9/mdNFtZqJqmldb5O+2m4JOpwydj4sd2mXjv9ZIB01qn7seg==
X-Received: by 2002:a17:902:1d4a:: with SMTP id
 u10mr18697449plu.122.1549585801790; 
 Thu, 07 Feb 2019 16:30:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:30:00 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
Date: Thu,  7 Feb 2019 16:29:40 -0800
Message-Id: <20190208002941.30343-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_163003_197741_0177D613 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add nodes for two PCIe controllers found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 89babc531380..8ceab748ed04 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8mq-clock.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -539,6 +540,63 @@
 			};
 		};
 
+		pcie0: pcie@33800000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33800000 0x400000>,
+			      <0x1ff00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
+			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
+		pcie1: pcie@0x33c00000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33c00000 0x400000>,
+			      <0x27f00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
+				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
