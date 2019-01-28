Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FBC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:01:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF292177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LN0nS5NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF292177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ln6Slf+L+S+st390AM6ZFvXDxe/QEU9ugwX1u/Lx49o=; b=LN0nS5NIV+pKVR
	I2EbhYbtEvvat7m9miEmoBpi6yMGJKBj97MWrgUHufvXPeINOuTShE+yUXC1yB6DSiZTLmHDSG9xu
	dKkCeOwQ9cut2zsGHLSW7wEgCxrxfz9MMVp0UJYcEdajdbQKb87I4ky1eQdLtd19GfKpiIJKEtKqU
	qpoturPi4FmNnTIxw8StkfCCma0DLagQ92XQ+i6/yzcms16GJDN/AyVd+1J5fzeErYHSWMKCL427n
	T8UqaIbYNI6ZtNJ7tlMHus60U7SQTL1xl5RnNrYECXyA6D4ew773tfWfDPk8ZbK8SDOSrp1GwpmKF
	rOWK1dnBVcFoMHiWzhiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goD5k-00047E-0Q; Mon, 28 Jan 2019 20:01:12 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goD5U-0003rf-Vm
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:00:59 +0000
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
 (Authenticated sender: repk@triplefau.lt)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 906891BF206;
 Mon, 28 Jan 2019 20:00:48 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] arm64: dts: armada-3720-espressobin: Configure RGMII and
 SMI pins
Date: Mon, 28 Jan 2019 21:07:27 +0100
Message-Id: <20190128200728.17747-2-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128200728.17747-1-repk@triplefau.lt>
References: <20190128200728.17747-1-repk@triplefau.lt>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_120057_776242_BFB7B305 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to be able to communicate with the 88e6341 switch some pins
have to be repurposed as RGMII and SMI pins.

This fixes ethernet support on system booted via a bootloader that
has not already configured those pins (e.g. mainline u-boot, or vendor
u-boot compiled without ethernet support).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 846003bb480c..b60897edc885 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -196,6 +196,8 @@
 };
 
 &eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
 	phy-mode = "rgmii-id";
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e05594ea15fb..f61538910901 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -271,6 +271,11 @@
 					function = "mii";
 				};
 
+				smi_pins: smi-pins {
+					groups = "smi";
+					function = "smi";
+				};
+
 				sdio_pins: sdio-pins {
 					groups = "sdio_sb";
 					function = "sdio";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
