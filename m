Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CF8214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B1bRthad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CF8214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jwv5bOkU2LtS/oR2Ra6ZXooA70brT4f8m4YgRPSFkE8=; b=B1bRthadLyn1puMBb+u8rbVKK0
	sGCteOFMsniNTZVVHEBYVVllQI4GgME7GIQaWfnkH+oy0v1Vq/H2TOnKko+9f5igXlYvZtZSDMbSR
	Ru3tG0s8k6vRuh5OC+oHJQubnSrafPUa8+TVC95VbWrPZThr7LvNEwoGoT3JYrmWjnyZ7IL9ZKxzM
	t/z+wkSeSpw9lUMUyetUlYg+l0MYvQ4krcL9JYyBvN+FqwPralmAjziDy8yMmZqNa9cWojQne3E3Z
	rKLC1a16b0aCH5XquU6+itzv/QNSD2dx/yyUF+7VQIKJLaRMcz9ug0jn/KBs2fgA092zgHIavP0f0
	nEWso4hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzOZ-0004vw-8q; Tue, 08 Jan 2019 21:58:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzNe-0003vv-Kq; Tue, 08 Jan 2019 21:58:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E33015AD;
 Tue,  8 Jan 2019 13:57:50 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91EB03F5AF;
 Tue,  8 Jan 2019 13:57:48 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH 4/5] arm64: dts: rockchip: Add NanoPC-T4 IR receiver
Date: Tue,  8 Jan 2019 21:57:26 +0000
Message-Id: <a21283067b8d5132df430f3eca6a01ed9eebf1b2.1546981251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_135751_540442_677D2DBB 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In common with most Rockchip reference designs, NanoPC-T4 has a passive
IR receiver connected to PWM3. In lieu of a specialised driver for
PWM-based IR pulse measurement, running the pin as a GPIO with the basic
driver works perfectly well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index 623a03f2548a..84433cf02be9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -45,6 +45,22 @@
 			press-threshold-microvolt = <18000>;
 		};
 	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_rx>;
+	};
+};
+
+&pinctrl {
+	ir {
+		ir_rx: ir-rx {
+			/* external pullup to VCC3V3_SYS, despite being 1.8V :/ */
+			rockchip,pins = <0 RK_PA6 RK_FUNC_1 &pcfg_pull_none>;
+		};
+	};
 };
 
 &sdhci {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
