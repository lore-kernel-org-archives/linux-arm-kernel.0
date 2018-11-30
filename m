Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6496420867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RDlUvSdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6496420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nbhH3kTnEp92YPocdsYOaLy+Ul8Avtm1LAMNZfvKlJw=; b=RDlUvSdiUDesdt
	aTcEkGKONnPkIouzzndXnr56FViT1qNs1XTj2LcvXF71nmCwruNIsjCLATdatlnuATyZZMy+8y+Yw
	c1FoPfRd0EMB2YHmCyupwCpaK7Z87Y5kWnNtFaxj8xocVf+WhwGlGassr9y/FIQ24/qGf7lvE/Bkq
	Ym+8s/Q78ZUD/92Gr6PZetrjzy4OB5KcoCgjVtAb8OJLj14TvA7mWJQ8oxgxDWQ67h1MwXuZuGI73
	6YVZZICgobYEQP3ZOP/n/wOTZHoBTFm53+5oJwOwvh/oHpNDbX+gY52V8TjzHA49N4tR/kgwrnOlg
	7lzczt0rQLIXxd+ghxNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnF0-0003vN-0M; Fri, 30 Nov 2018 18:10:14 +0000
Received: from mail.bugwerft.de ([2a03:6000:1011::59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn1M-0003E8-Si
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:56:10 +0000
Received: from localhost.localdomain (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id C275C2C459A;
 Fri, 30 Nov 2018 17:55:39 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH 3/7] ARM: dts: pxa2xx: fix hwuart memory range
Date: Fri, 30 Nov 2018 18:55:39 +0100
Message-Id: <20181130175543.32628-4-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130175543.32628-1-daniel@zonque.org>
References: <20181130175543.32628-1-daniel@zonque.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095609_057437_4EC64F71 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The memory range for the hwuart is at 0x41600000, not 0x41100000.
This also solves a conflict with the MMC controller node.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 7d3dfa8259f8..30e77ebbcc4d 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -117,9 +117,9 @@
 			status = "disabled";
 		};
 
-		hwuart: serial@41100000 {
+		hwuart: serial@41600000 {
 			compatible = "mrvl,pxa-uart";
-			reg = <0x41100000 0x30>;
+			reg = <0x41600000 0x30>;
 			interrupts = <7>;
 			status = "disabled";
 		};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
