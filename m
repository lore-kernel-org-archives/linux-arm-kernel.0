Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D404C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9EA20828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ctkV54e6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnJOrBNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9EA20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=R/3UpNr41L9ZMTRqpRKO+KqLgMkgsyN8r9w5NM/+L8s=; b=ctkV54e6NjyyOVwDXQXWazmEmK
	2GyZLZ1P+QYQ8od36UvHJi9CM5rMgcS7CdGViQyzb4Wuk/2hjWypi+CwWP5JX5hn4vnsDJaoaqtOP
	QKrMDLePp5SH1i+HVHHmwx/ILMWD6uS1mmMN6HEXL8W1nWxdGNN92N5RElx/6KeHwcOtXvsqylsBf
	Bh7twNz1ZZTJrW90uTkNk+hV472V8asBrhOELxjtor76fVBHPN1ChLjfvlQDK1ooPi6ZeFkldapPR
	QA+HCfEHQK5oqEOVtwAxiESWMswbbhtn7EPz0M1kTjAy1yMO/7Oy0rmp32pCxG9WKRBklOu40JdR7
	q94OT0YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEmX-0000EQ-08; Sat, 29 Dec 2018 13:36:01 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkR-0005PI-1l; Sat, 29 Dec 2018 13:33:55 +0000
Received: by mail-ed1-x543.google.com with SMTP id p6so19513851eds.0;
 Sat, 29 Dec 2018 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+VCBySQXhTipKQxLBqodKfMWCHahqpPnV/2FwaZKvSU=;
 b=VnJOrBNmue5O1PtnKiJd63+LT/iFauDAvwKw8er3zs8zahN67/i0CX17jsC0w1dRmq
 lT2D6DPEEs/OL6Fem9t5ic1LruQyXG7ABxEXAe41gstAzeFrtRwSmLH+akGaaMC0LJCe
 V+ZQIc0D2VsPoTLpBl3gdryCpdS7B0iFrsE3jB36ZsGxpf1+x2l4Oavz6TjfGQwRTbPu
 lrQ7NA63eVK5DmNnqDg/VsnMlsC30oeSLDn5qgdMYmej/wGq8Qo7M7OztCA3YpNl8QSi
 WQ1llXJrsmZOL/siYNlLDYcigWyESKkOPSCSy7qrV1wQFM8XKvfCzyOZB/4oxPiHHh/v
 qBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+VCBySQXhTipKQxLBqodKfMWCHahqpPnV/2FwaZKvSU=;
 b=e7XANICjTCng99QBjpLT/BSCz+3OhRr7ruj0Gir2wLdh2yXAPgGyocj5hy9yCdizY4
 XokrMJnJ4sP7jDZ2moful3HSJvhMagCaIMpGuAFve+bcDMQMyuLwETvlfsNcuvhSjfkG
 utD37Wb5d+6sD4NUlGmEvlHYpdeLbQuJYnWe2C/3j5XLQMd20VfaKel49vWRNBXqDd5k
 K7/KZkkKUkdd6hv5z9Oldjh/CfAJs8CU+brGKNVpLDyn5fiWS96mRupGO58//B3B7fJL
 HGZ1aBYzweI8JsLdKibq25fZt48VZHh2g5WWdRGORBrGaGkouoy7FrtotZO1TuqQFCgr
 1JLQ==
X-Gm-Message-State: AA+aEWbIpQOmD1mwbU0/X8iCNL1d31r1VlNCVmqPFDcWIF0EY7RzEmOs
 +8PN+YzQ88NWvQ+XXliWljM=
X-Google-Smtp-Source: AFSGD/V6HJRw3Vzsiaq98oDpDoYv9GVOGWVNVzOI44C9EZh1rRPMFha91360Py5UrN8MQSqeTZo82g==
X-Received: by 2002:a05:6402:1286:: with SMTP id
 w6mr26493428edv.53.1546090419242; 
 Sat, 29 Dec 2018 05:33:39 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:38 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 5/7] ARM: dts: rockchip: add rk3066 vop display nodes
Date: Sat, 29 Dec 2018 14:33:16 +0100
Message-Id: <20181229133318.18128-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053351_400394_8D532D89 
X-CRM114-Status: GOOD (  13.89  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

This patch adds the core display subsystem and vop nodes to rk3066.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b6b3a77da..653127a37 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -44,6 +44,11 @@
 		};
 	};
 
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop0_out>, <&vop1_out>;
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
@@ -57,6 +62,48 @@
 		};
 	};
 
+	vop0: vop@1010c000 {
+		compatible = "rockchip,rk3066-vop";
+		reg = <0x1010c000 0x19c>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC0>,
+			 <&cru DCLK_LCDC0>,
+			 <&cru HCLK_LCDC0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3066_PD_VIO>;
+		resets = <&cru SRST_LCDC0_AXI>,
+			 <&cru SRST_LCDC0_AHB>,
+			 <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		status = "disabled";
+
+		vop0_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	vop1: vop@1010e000 {
+		compatible = "rockchip,rk3066-vop";
+		reg = <0x1010e000 0x19c>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC1>,
+			 <&cru DCLK_LCDC1>,
+			 <&cru HCLK_LCDC1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3066_PD_VIO>;
+		resets = <&cru SRST_LCDC1_AXI>,
+			 <&cru SRST_LCDC1_AHB>,
+			 <&cru SRST_LCDC1_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		status = "disabled";
+
+		vop1_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	i2s0: i2s@10118000 {
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x10118000 0x2000>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
