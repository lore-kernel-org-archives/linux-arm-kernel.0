Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E942070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q3a4M1r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E942070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilka.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qmjc/qJePwUvbhZmyd2Km1OE4NZtYynS/5lSsYrBWnQ=; b=Q3a4M1r0KrJq/o
	OD9AIxl+EhQXfMVd1bUh9J33k/nxACEB3QJtbWUO0nlxpBP2SMppOTUtxgsw+teplNBSOEeNwJBiQ
	j0hf2gJxHRopdInZBlmSaDBcRE5L/s3r7s8lUdjoLFpAIUJzx02bNsCEeaanBgEkvZ/yda812XEo5
	i1WrntfBp3Ti8nIm/oaiGV06HoRYldInKIM0s030M3/kQPOHoP5C952/R5DyI4Y1MEX6tBdlRsOyk
	qsNbU5eG9zBoS9ceyL1FFFSS+AN9OsHNKUmF2gDkdKlQEiQdKqXKRKlKzLkCoswQ9v2LsxjckWCEc
	6/opnJGa/YkawQyeUcLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt4Zj-000459-Pl; Mon, 11 Feb 2019 05:56:15 +0000
Received: from bbb.xilka.com ([2001:470:1f11:5a5:16da:e9ff:fe11:e54b]
 helo=xilka.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt4ZV-0002QW-EW
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 05:56:03 +0000
Received: from bbb.internal (localhost.localdomain [IPv6:0:0:0:0:0:0:0:1])
 by xilka.com (8.15.2/8.15.2) with ESMTP id x1B5rteZ022225;
 Sun, 10 Feb 2019 22:53:55 -0700
From: Kelly Anderson <kelly@xilka.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] Add mtdparts for expressobin with current u-boot
Date: Sun, 10 Feb 2019 22:53:48 -0700
Message-Id: <20190211055350.22181-1-kelly@xilka.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_215601_763619_9CDB48D3 
X-CRM114-Status: UNSURE (   8.16  )
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
Cc: Kelly Anderson <kelly@xilka.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Kelly Anderson <kelly@xilka.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 846003bb480c..91aeffe83ab4 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -94,6 +94,7 @@
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
 
+		/* Partitions for U-Boot 2017.03-armada-17.10 */
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -101,12 +102,12 @@
 
 			partition@0 {
 				label = "uboot";
-				reg = <0 0x180000>;
+				reg = <0 0x3F0000>;
 			};
 
-			partition@180000 {
+			partition@3f0000 {
 				label = "ubootenv";
-				reg = <0x180000 0x10000>;
+				reg = <0x3F0000 0x10000>;
 			};
 		};
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
