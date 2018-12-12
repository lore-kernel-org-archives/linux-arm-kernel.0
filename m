Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF34C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:44:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E9320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djXaSEZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E9320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fLGza9T9IyzgO0kvX74/TT1ceVGKikDcLEMZI3ha5U8=; b=djXaSEZRo2EEmf
	ihVxNCg65dcNI9YfMetXuzV9OqgN6TmpBBPYaKr1XItAlim9L3qmWF4DkiAABL+oDomKpM+0vjPSs
	trN42yVR3Vh/66yN9UNSV75oPJqPRh+AjZy6k9pTr14DWwB8050M4ccBeyq/YJJPvken47kjfDGol
	5s06u3LLZd/quIwk7BJL5KoarOsN7GmHGweH8IMyLeD9hZ9SC98KuYv5QjtfMhrIJi86xxrr3Daw+
	VwKzAsHM6k+J38DAeyb1EwLCb94KmOqSKzVFT9Z2I1TfNquX42llm/ss/skbpB8G3X8Bd7dxiyCVM
	wNTjYpD5WTLU3smTD6Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyG2-0001vP-2q; Wed, 12 Dec 2018 06:44:34 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyFy-0001uz-Fo
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 06:44:32 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id 7ED8D44011A;
 Wed, 12 Dec 2018 08:44:16 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] arm64: dts: marvell: mcbin: fix PCIe reset signal
Date: Wed, 12 Dec 2018 08:43:26 +0200
Message-Id: <2e9292493b5bb9811870adba3e43b2866c65169c.1544597006.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_224430_746933_49BD56DB 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MPP52 signal is on the seconds GPIO instance of CP0, which
corresponds to the &cp0_gpio2 handle.

Rename the property name to the standard '-gpios' suffix while at it.

Fixes: b83e1669adce6 ("arm64: dts: marvell: mcbin: add support for PCIe")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: rebased on top of mvebu/dt64 (Gregory)
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 29ea7e81ec4c..329f8ceeebea 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -183,7 +183,7 @@
 	pinctrl-0 = <&cp0_pcie_pins>;
 	num-lanes = <4>;
 	num-viewport = <8>;
-	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
