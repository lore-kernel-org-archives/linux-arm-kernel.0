Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A5C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:01:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6828E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+GKiLea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6828E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rbLbmtAQBtK1dRzIONZl/b7UPREBmEp7VkRdMXPSsSA=; b=U+GKiLeahlNzln
	Y7RbakbakrYNsyMTwaiVbqGUxUkTtx3RNDGEx0RKm0MJlRxzC657yRVhVVHrdff/eK3BdZsbQSKS2
	CSyBt7MWJ1wNsGdljXBbvNqmV+o28kor/+JcYqiM9nrJvYeu71K0SC/nsNXzXleku4e7JfjzMLXBR
	0eZujnzw7MwIRAKpPFM2k9oaR/G3p46e92lnqVJRNRHKnuBjpYn8jnR+iTtGLDFMJgZZ7kdzMwBJj
	wzV/cSHUB5xEe0Z9v6D2xW/PcCOF3HVf2hrNcBRo9guIns+aTdzGSVELQ6A06pcMPkjoo7nQcXafV
	kEnB78nDDtlVvKXC5c7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goD5y-0004Kb-Ra; Mon, 28 Jan 2019 20:01:26 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goD5c-00040A-MF
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:01:07 +0000
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
 (Authenticated sender: repk@triplefau.lt)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9F2D0C0002;
 Mon, 28 Jan 2019 20:00:54 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] arm64: dts: armada-3720-espressobin: Set mv88e6341 cpu
 port as RGMII-ID
Date: Mon, 28 Jan 2019 21:07:28 +0100
Message-Id: <20190128200728.17747-3-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128200728.17747-1-repk@triplefau.lt>
References: <20190128200728.17747-1-repk@triplefau.lt>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_120105_250375_944E3788 
X-CRM114-Status: GOOD (  10.52  )
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

The mv88e6341 ethernet switch needs the cpu port control register to be
set with TX and RX internal delay in order to work.

This fixes ethernet support on system booted via a bootloader that
has not already configured this register (e.g. mainline u-boot, or
vendor u-boot compiled without ethernet support).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index b60897edc885..86e8a1e3207f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -156,6 +156,11 @@
 				reg = <0>;
 				label = "cpu";
 				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
 			};
 
 			port@1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
