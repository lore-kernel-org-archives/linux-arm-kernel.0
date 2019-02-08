Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306DEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:15:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F229220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HAzSNw2a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Q1xtiAr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F229220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JmcxLdpcdFj09E7jNpr08DG67R2JI5yxx83gVqvWYp8=; b=HAzSNw2a26HQo7sVzaKft6jNrQ
	S/8umanWZdavwKBJ7aXDHE0kXhlnUPULXXIr7droEfyHU8Wg4eBn6S1uu6YKG+I8NnX2Wiv0UVZX+
	N8da/S+DbG0DBNyXz9Cm0VbdSzoOxYe9PYAZhyGiXmXYtHwhh1RxGHSCugYqa0nf41itGlzynaolQ
	EvQdWmVm0xkKD0+eTUPvpTa2QHMtvp5KUs9slJZd5ZJf/EWnsYPggvaVChtKhpCvBI0pyvTM1k4zG
	/X9h21cfm5ktqIWYtQudqStA6dUK65Rum1743YPG5LBqkRMt5NNwUtq4v0UHwQHyCCI7A8Y1Ms9K5
	I5Bk4W3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs47m-0001Np-NH; Fri, 08 Feb 2019 11:15:14 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs46y-00084G-CC
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:14:46 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7D62025BEE2;
 Fri,  8 Feb 2019 22:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624404; bh=A7yIwmiLUn76O7GzTFRTW09H+yqoCL+XMMS+Rx6YHF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q1xtiAr8Nh5naLPM+QyGoS7//W00Y51cebnnzIfaDUo4rQ2zLi8b+OaEJjWG9bvLY
 RHRzy1IfXgRw7+NTBRQYmsjwB2RatraAwQZfcEIagVLmEdYHKBgEnX8+HKNwHXo+kX
 YqqPU7tzJrcYuSRu1/sPPBvaEOj/GD74J8feXTtY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id CC2FE940461; Fri,  8 Feb 2019 12:13:22 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 03/12] arm64: dts: renesas: r8a774c0-cat874: Add pincontrol
 support to scif2
Date: Fri,  8 Feb 2019 12:13:12 +0100
Message-Id: <4cf1f6cec1e99410b5cdc0b865b93bebf68b3fdb.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623801.git.horms+renesas@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031425_259429_CC20C09E 
X-CRM114-Status: GOOD (  11.11  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds pincontrol support to scif2.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 6eababc93275..c545ce5320c7 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -32,6 +32,16 @@
 	clock-frequency = <48000000>;
 };
 
+&pfc {
+	scif2_pins: scif2 {
+		groups = "scif2_data_a";
+		function = "scif2";
+	};
+};
+
 &scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
