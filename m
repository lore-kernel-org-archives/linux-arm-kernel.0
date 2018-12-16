Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72493C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:35:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D229217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WUvCW0ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D229217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VsjA97gcb3t7SliAz57dVIHz2oRcOSaEOUEAORvJ86g=; b=WUv
	CW0uaDRRantR+F/2R/GTNp8X9L/qiHnGvaWQb70+67ci9Gtke2aT7wbhxVfPEgAT8EvSAS4jR6d9H
	2Dkodl7nyb6QAdqqd9sE3WmHZTO6cNzG293njsPK4SQ7vsp293sh10XHL5GT8Gksq5iKk+D1FtzTM
	EIsoVqBuTeXTfbZAfS/9QXxLQuaU0hLgZRhQDFXHyXEaoLdtoIu9l/xpuPhFODNHeaz4Qu3upKUGi
	BNglmljKoKwOZQVzdvVGvE/y2/U0wEx9wkE/KvsJ+SYWj5UzsSp+by57zfuHv2ZYqO3uyrv8YzOv8
	i0RQiuDTx7R1oRpK7JJE3wrPSUnLQ+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYSpk-00042S-4I; Sun, 16 Dec 2018 09:35:36 +0000
Received: from mail.cosmopool.net ([2a01:4f8:160:20c1::10:107])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYSpf-00041M-Mw
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 09:35:33 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id C37089015D9;
 Sun, 16 Dec 2018 10:25:36 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.your-server.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5eu-7tMRcwyr; Sun, 16 Dec 2018 10:25:36 +0100 (CET)
Received: from huygens.ccbib.org (unknown [10.0.10.106])
 by mail.cosmopool.net (Postfix) with SMTP id 3F4F4901150;
 Sun, 16 Dec 2018 10:25:35 +0100 (CET)
Received: by huygens.ccbib.org (sSMTP sendmail emulation);
 Sun, 16 Dec 2018 09:25:35 +0000
From: Harald Geyer <harald@ccbib.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] ARM: dts: sun4i-a10: Add PMU node
Date: Sun, 16 Dec 2018 09:25:24 +0000
Message-Id: <20181216092524.20337-1-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_013531_902038_1F953C66 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Harald Geyer <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is necessary to use 'perf' for cache profiling etc.
Tested on cubieboard with 'perf stat echo foo'.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

While looking into this, I noticed that the dtsi files for the allwinner
SoCs have no information about caches in them. Is this on purpose?

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5d46bb0139fa..a2fb473cbb9d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -184,6 +184,11 @@
 		status = "disabled";
 	};
 
+	pmu {
+		compatible = "arm,cortex-a8-pmu";
+		interrupts = <3>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
