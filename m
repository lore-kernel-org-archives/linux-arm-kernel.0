Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED68C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:57:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B967218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sXeM+YXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B967218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AToeDLqI7ms8PJOcWdt1a5KI45MPgHdexKzL5vE6900=; b=sXeM+YXs4htkqQZ9MMv52ufYBB
	3SoZvM1pAEJpXBCmKIZDLCVY/nZDVfIo0LOsNaP3UWs0/q00KH/FQd2zbICOnF4nLY0fPJQCsL1/r
	dQR4VQbpzEkchO0O0QVYX7GPKgTq8MQpLqvTeczGBbeo9cU4Q/dGu+nzRgiUUuR3H1QE9Y0yfoaZ5
	R9kI4vcdekcKrxvLY7uW1LM2LQ4EhPSKqd7GR/V74toDzfCBK8yfceiiADpOjW8ls45OVlrhv59g+
	zMIVgVUTgr2DMsswNUy2AnwO1FZCaezvGThAWoCm8GNsHo6mwOLf0Y3doObIbcUfWhzTeHzPH2b7u
	D05+S8/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5is-0000tq-QN; Fri, 25 Jan 2019 17:56:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5iE-0000Mk-0T
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:56:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C045D1650;
 Fri, 25 Jan 2019 09:56:17 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4AB43F5AF;
 Fri, 25 Jan 2019 09:56:16 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] arm64: dts: juno/fast models: sort couple of device nodes
Date: Fri, 25 Jan 2019 17:56:05 +0000
Message-Id: <20190125175606.6607-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125175606.6607-1-sudeep.holla@arm.com>
References: <20190125175606.6607-1-sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_095618_059842_1EFDB118 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: devicetree@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sort the couple device nodes with unit addresses which are out of order.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi        | 70 +++++++++----------
 .../boot/dts/arm/rtsm_ve-motherboard.dtsi     | 12 ++--
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 3a72c04247cb..7446e0dc154d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -220,6 +220,41 @@
 		};
 	};
 
+	replicator@20120000 {
+		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+		reg = <0 0x20120000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* replicator output ports */
+			port@0 {
+				reg = <0>;
+				replicator_out_port0: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				replicator_out_port1: endpoint {
+					remote-endpoint = <&etr_in_port>;
+				};
+			};
+		};
+		in-ports {
+			port {
+				replicator_in_port0: endpoint {
+				};
+			};
+		};
+	};
+
 	cpu_debug0: cpu-debug@22010000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x22010000 0x0 0x1000>;
@@ -452,41 +487,6 @@
 		};
 	};
 
-	replicator@20120000 {
-		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
-		reg = <0 0x20120000 0 0x1000>;
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		power-domains = <&scpi_devpd 0>;
-
-		out-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* replicator output ports */
-			port@0 {
-				reg = <0>;
-				replicator_out_port0: endpoint {
-					remote-endpoint = <&tpiu_in_port>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				replicator_out_port1: endpoint {
-					remote-endpoint = <&etr_in_port>;
-				};
-			};
-		};
-		in-ports {
-			port {
-				replicator_in_port0: endpoint {
-				};
-			};
-		};
-	};
-
 	sram: sram@2e000000 {
 		compatible = "arm,juno-sram-ns", "mmio-sram";
 		reg = <0x0 0x2e000000 0x0 0x8000>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 102e93744edc..454cf6c44c49 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -167,6 +167,12 @@
 					clock-names = "timclken1", "timclken2", "apb_pclk";
 				};
 
+				virtio-block@130000 {
+					compatible = "virtio,mmio";
+					reg = <0x130000 0x200>;
+					interrupts = <42>;
+				};
+
 				rtc@170000 {
 					compatible = "arm,pl031", "arm,primecell";
 					reg = <0x170000 0x1000>;
@@ -193,12 +199,6 @@
 						};
 					};
 				};
-
-				virtio-block@130000 {
-					compatible = "virtio,mmio";
-					reg = <0x130000 0x200>;
-					interrupts = <42>;
-				};
 			};
 
 			v2m_fixed_3v3: v2m-3v3 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
