Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36FC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDBD2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGmGqsv3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="B/81wz7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDBD2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=pSApRqLemnRPkCMjefap+AvPoHPMV1a4nJzTPwEg0wI=; b=qGmGqsv3pHeZoGyhfOCGf8N48a
	1xihDcpf4W1ZCzeJN3MlHcXCtQq+ej+iLsgH9q7ATV/5BgdZhaItujMy9+5i8xeiL4K3YDcKKYADu
	ADb67Y4mQj7ireEEdfYsQNB48N7zZPvBgUciCu5usMBEIYEBIwb29LhSutuqh6/o2As9NGhlfR4uf
	8H5iAqfPlGUpGBrJM0CYzAKfdWEheTl8+qa5Ypa4CpAKly6rYlYQjV/dAMqjcvKPJbsNU7Sllty69
	HgqJdq/GhDNkr8XmBks8AYCU9FJEULMBqkKHJsfaMp2vhKLBcQ2fK5JW6TPsZV/KpjzsNQkrj4U/b
	7OYMTjhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmggV-00010D-5c; Thu, 24 Jan 2019 15:12:51 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgfo-00009z-Ih
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:12:12 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7259F25BECA;
 Fri, 25 Jan 2019 02:11:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342718; bh=rEaeMIZIXAoUg6EBBTyLBlRuzU30ookQOF9Siip9nlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B/81wz7YRGNvpbcMEMPA/mrfQBTqxAjQjyaMp6WLKpq2BPjSU9JE6tc1HPDs4WwwU
 x/sekAdN54nCdL2Eb9DMU2UaBlccbL5OXICOpngMM+uFYyMwoTKomVXuE6OJzWooSp
 En97/fdZ7mx3XYcktC8yhl6SYa3rkc0epkzuf4js=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 8DFD6940793; Thu, 24 Jan 2019 16:11:56 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: r8a77965: Enable DMA for SCIF2
Date: Thu, 24 Jan 2019 16:11:54 +0100
Message-Id: <05c8478abd485507c25aa565afab604af8d8fe46.1548165440.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548165440.git.horms+renesas@verge.net.au>
References: <cover.1548165440.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071209_211379_431C01C5 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

SCIF2 on R-Car M3-N can be used with both DMAC1 and DMAC2.

Fixes: 0ea5b2fd38db56aa ("arm64: dts: renesas: r8a77965: Add SCIF device nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 6dc9b1fef830..4b3730f640ef 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1068,6 +1068,9 @@
 				 <&cpg CPG_CORE R8A77965_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
