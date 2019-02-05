Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F0BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F4B217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNGfAJDq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIJALo2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F4B217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sdtDgvAQ8f1A82J2zd60Q+0b9GN8mKiSr5eo2BreZdw=; b=BNGfAJDqNj+/wv
	1QrYqa54pqpmZz7ntsv9/FuNXwfdZJv1n0/cIPAwTMhxBagrajJcrGe7I98EX4Nh8Qb8KN6zJnQ5D
	Mc6nl4MwCKvHRs2jzhZ77Wz6HOVtzgYCr3HxyPx/vmSlHXjIIB2vd3tE7V14sJFewY+J0OEScRy3G
	4VRwlEBB+K8ED2+POwtC6I+deLk5zEnPwvRnkDxcZEaRldXOklvHx3NCwvVIWiHiLKw5hQXRAuwIo
	SElOwG/uc6gX6HOrkzjT5vtnMpM22xPBAaQRtjN3tYqzk2MuFbgQPWjyIs/leemzNuvSimmsM1Rwa
	ddRVuPeZ6tvoG8J7GwzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9tl-0002jf-09; Tue, 05 Feb 2019 23:13:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9tj-0002jX-56
 for linux-arm-kernel@bombadil.infradead.org; Tue, 05 Feb 2019 23:12:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nqA7OEkKWalnsJf+f6DEK0O6lbcSxS1o1eCuJJptaFQ=; b=oIJALo2GvLisG2rCaKiMOVe7X5
 0e215fSYl6uaAMimvlWttY5x2UMUsnJ5dil3PpKtiDZdWNzY0Vt7nwal9YihEAUSFascwJKIQ7P/U
 XNh8FxgbSbuenWFItOcXUwPg2u/+F5b4Z8EV3F3tV94ALIOMqCFvUaCMWdb1+81a/bsAR/RaCdqhA
 bs+O77btblbUYQ3Cr09OIEl8iQ4vqEC7P57dd3RYYmFLfk9LFZQ06e3hnMJbgQXw7u5LyfzRvqhdY
 FUPYKDux7bCTQfVxrlMznHbcL0pIvsg7OHphCaQFzqG428Dlj4RLAlbpSTMEozHbvRBbBfw3G8rmb
 Omb5AhHw==;
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9tg-00037V-3I
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:12:57 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2DD9E1BF204;
 Tue,  5 Feb 2019 23:12:22 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] arm64: dts: marvell: Remove unnecessary
 #address-cells/#size-cells under flashes
Date: Wed,  6 Feb 2019 00:12:08 +0100
Message-Id: <20190205231208.11547-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_231256_159298_2181C4B4 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

By using the new binding for the partitions for the flashes we don't need
anymore to use #size-cells and #address-cells at the flash node level.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 4 ----
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 412efdb46e7c..d20d84ce7ca8 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -66,8 +66,6 @@
 	status = "okay";
 
 	spi-flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
@@ -169,8 +167,6 @@
 	status = "okay";
 
 	spi-flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <20000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 1bac437369a1..9f4f939ab65f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -81,8 +81,6 @@
 	status = "okay";
 
 	spi-flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
@@ -214,8 +212,6 @@
 	status = "okay";
 
 	spi-flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <20000000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
