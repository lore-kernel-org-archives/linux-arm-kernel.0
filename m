Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601EF20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4oDqU6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601EF20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zN5ua3ZH1HrZnbzuF+sCYdPdNYsH4o/yKQ9iX6sjb6E=; b=K4oDqU6kVpIhfY
	zpscIgsuloMbASQbkcvyE6/vLd6RBVM7EdqprO83Pn7vQSRwUycTStDP3TYyYO0kvwb1rxIMlRLwU
	T+JaSi0P8kbG/VvAOosIVXHIfetTjEOclBYE83P0NqYKQjIEooYl+oEqmwLlzatKsTFYEJNa5pu1l
	R9gjmxVTQ1lEZNQRhGwkEF6NZq8K+MYEC1fIzgA3Z1MdgHqKIvrd9POXF6bH/Otcm7P82nwHqPY4A
	lJfMjtfi2cAbuT7hTqDyYMV+mlBVwVioUr6t+Gnt6dq+2Ei9LUpWRW9bJt+Q55kqPjzXwCqx5NM/y
	er6H3xU3eqVsWOtfBhOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj10V-0007AO-M8; Mon, 14 Jan 2019 12:06:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj102-0006jj-GR; Mon, 14 Jan 2019 12:05:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 541FD15AB;
 Mon, 14 Jan 2019 04:05:50 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F1513F5BD;
 Mon, 14 Jan 2019 04:05:49 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add NanoPC-T4 IR receiver
Date: Mon, 14 Jan 2019 12:05:33 +0000
Message-Id: <7356fc6d1e3eebfec0408d0ca61b32c11e4994e9.1547466003.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1547466003.git.robin.murphy@arm.com>
References: <cover.1547466003.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040550_718824_D2A313F9 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
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

v2: No change

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
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
