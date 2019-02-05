Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092D0217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oe/ktz0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092D0217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YP1cYSuxpSwpAcFc3teb89bRswecrUtIjIkQ/e+uT5g=; b=oe/ktz0dBaAbPD
	YDQq9wtD9CJBt+NrqdYeBLW3h8j6a7F3Y7lLM43YcaSY7hbhAcQhsspshac4jvXYLFdI7BjliucJI
	yStJLY7kU2XdeDdylR0J9YH3louPtrsFiToLZW+PM7Sh1UyaPEetvZ9K1KAejgDVJ/H2yTmUtcPwg
	n3ihaJE1jOry2Ixyco0r4NgZTPEuBU/oj5uCHns7f1SYKdBn153yi/82hG2r7yGtbByeLhyece31f
	UNYjMweHOqffyzh2CvwzsuxAEA4VtUnpHOYCMvfhFo7bwyxu2rGjW4E2ZB7uhKUayr/n2w7JrJEoR
	xkMDtcGKSZChQNZzTLCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2ss-0004CG-9G; Tue, 05 Feb 2019 15:43:38 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2rp-0003Ak-O9
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:42:40 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 76C635FD5E; Tue,  5 Feb 2019 23:42:26 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark
 eMMC HS-DDR 3.3V capable
Date: Tue,  5 Feb 2019 23:42:25 +0800
Message-Id: <20190205154225.14264-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205154225.14264-1-wens@csie.org>
References: <20190205154225.14264-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074234_192120_F4E880DA 
X-CRM114-Status: UNSURE (   8.02  )
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
Cc: devicetree@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Libre Computer ALL-H3-CC H5 is one of the few boards that can have
its eMMC run at HS-DDR speed mode. Mark it as such.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index 95e113ce8699..d68bdfea2271 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -12,3 +12,7 @@
 	model = "Libre Computer Board ALL-H3-CC H5";
 	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
 };
+
+&mmc2 {
+	mmc-ddr-3_3v;
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
