Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65016C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369F520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJvuiCUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369F520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m0YFo8JaHQpw/mEvtSp/C0tyHQVY02RS4NH448YWinY=; b=XJvuiCUOJHN85k
	h951roPuHa209kxEjP7KKZkwfx2b/nIXTxNQtEGrbvJwnpf4K5u5pentG72OfkFh1Ump9NLVqeo19
	KVvfiTRvn2ZBTSZvh1NB6VB1d2xmovf36JhjGV2Hy8mL3AMfq+D46zixK3E1VQXZ8m1hPPTgjl/CC
	X/tyqSInHMbJjIj2wHvPwGWkPJz8yzU5wIRi2Gu4Ljsjn8DWaYxY9R04C0PPM8ekvPDL4m6Ialn4h
	vChmEFt1icu2JA9H1HwpRY0lJ2f5j8GLnA6bQ8yGUeD+NTuHQJ1+WtJWWLgle5wddY8pYdMEX9HoW
	4t8KANCmHUgmlxdmEvNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBnU-0007mM-Hw; Fri, 07 Dec 2018 08:47:44 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBnQ-0007aI-Fl
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:47:42 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 8CFC45FAAB; Fri,  7 Dec 2018 16:47:21 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] dt-bindings: rtc: sun6i-rtc: Fix register range in example
Date: Fri,  7 Dec 2018 16:47:19 +0800
Message-Id: <20181207084719.2009-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_004740_708304_0E4A92B8 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The register range for the RTC extends beyond 0x54.
Use the size from the user manual's memory map instead.

Fixes: 9765d2d94309 ("rtc: sun6i: Add sun6i RTC driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index ceb38abf1ea2..6b732c41392b 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -38,7 +38,7 @@ Example:
 
 rtc: rtc@1f00000 {
 	compatible = "allwinner,sun6i-a31-rtc";
-	reg = <0x01f00000 0x54>;
+	reg = <0x01f00000 0x400>;
 	interrupts = <0 40 4>, <0 41 4>;
 	clock-output-names = "osc32k";
 	clocks = <&ext_osc32k>;
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
