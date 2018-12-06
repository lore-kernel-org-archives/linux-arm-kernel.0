Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21310C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89C42082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJZalgRV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="FXAtTVKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89C42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8VpOfdq35Kb7Qn0R/z8yNl1keKa5fiZKHmTV0UNF/qU=; b=cJZalgRVBxV82MpZknss8DndDw
	OAL/VviZFmfgplyvmkxl+GtL+IThF3hE/qaaY+XQRixSg8fA+1398dWjj4d83Pjc+mvIXkQMy8bGw
	6KBLMxnD286FPir0uK84twHLQInP0NdyeK4Oqhd3gmccX2YpbrQ+naC74OZk9j507L8WkzZrV25/G
	shZ6kmnRmLb/mDOUH400x3jVw9maCewjtUOr3RYOlnWgsbN6LAowcu+hjVCzsHb0uqJ0u9LqKoiBv
	mNvVfXqewW1iRlW6bzaXlbnjMqTTOUnU8k4Sl7EIsow1dHdCf3/+62ncrZmnJXJDmvMvkBRlMJLRt
	qjxnBy2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1rq-0006gn-SC; Thu, 06 Dec 2018 22:11:34 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1f9-00077Q-Ce
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:58:45 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id ED22D25BEE4;
 Fri,  7 Dec 2018 08:57:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133457; bh=SA0DBV1WY2zrbZy/dU19BzCIgnixh7Akmjt6jvezsag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FXAtTVKAdl36C3E5/NTZMw7+5ajbCreAicoEalg85Mw/LWJ8r8wOCKwFjDLK/zOa9
 9ND6dBqQaxLvXb2X1CpKZdqd8xy/DCENVBEGu63eYjHgXp9NrxUnwAAhCStyAgEooQ
 a+Z/JdMktKQqEl8uJViLASjAqu7oMADyoX7yo4TU=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 7A622E217D1; Thu,  6 Dec 2018 13:57:33 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: renesas: r8a7795-es1: Add missing power
 domains to IPMMU nodes
Date: Thu,  6 Dec 2018 13:57:31 -0800
Message-Id: <41e30b515a003a90e336b7a456c7c82d8c3aa6a7.1544126426.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544126426.git.horms+renesas@verge.net.au>
References: <cover.1544126426.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135827_703933_6C76B2FF 
X-CRM114-Status: UNSURE (   9.47  )
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

While commit 3b7e7848f0e88b36 ("arm64: dts: renesas: r8a7795: Add IPMMU
device nodes") for R-Car H3 ES2.0 did include power-domains properties,
they were forgotten in the counterpart for older R-Car H3 ES1.x SoCs.

Fixes: e4b9a493df45075b ("arm64: dts: renesas: r8a7795-es1: Add IPMMU device nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 0fb84c219b2f..40d10daca852 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -28,6 +28,7 @@
 		compatible = "renesas,ipmmu-r8a7795";
 		reg = <0 0xec680000 0 0x1000>;
 		renesas,ipmmu-main = <&ipmmu_mm 5>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		#iommu-cells = <1>;
 	};
 
@@ -35,6 +36,7 @@
 		compatible = "renesas,ipmmu-r8a7795";
 		reg = <0 0xe7730000 0 0x1000>;
 		renesas,ipmmu-main = <&ipmmu_mm 8>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		#iommu-cells = <1>;
 	};
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
