Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E75C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:17:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4974421924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFrSlS5c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cbPuqAtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4974421924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AE3bOMYPYzG1QHJIsO3JQhxofux5Tne36PAVOD/8Z9I=; b=CFrSlS5cLNqrjqDiIr1YZxhJix
	mszSkc9rEADD3QY1DES+at0K54L4joL4yKSSHXAtndiCElNBtNtgcbOdMYhB0kJTAKx5lzKfCs2/e
	cBnB2QSsiqDKKYwsbuG4J0Xx7nvl6JPnmyc9p9ukUcQqeM9CH6uPfgGsdqAxYJTiIrECxK7p7OD2x
	rUGtnQQ1obFYtVcO4G3qcYcSt//MYARGFzTm4nfWAED7kIUv8JyAE7TqUAfxhx5FJcRjaI7NAr/ur
	9INSU0QT7FJnWeCfKFwFN6+SR+CbbEOWWitYlCQ4my+8E1E6KK4ahbz/31ZwJBqbrLuH5A0ahruvF
	9LNZpMfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4A1-0004Dr-8L; Fri, 08 Feb 2019 11:17:33 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs49Z-00084G-Cf
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:17:29 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id CFF3A25BEEB;
 Fri,  8 Feb 2019 22:13:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624407; bh=LXqCs4gHIThNGCSk0zwAk1s+XnKTUDKAw5NrXWT5taI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cbPuqAtIDUug4r6YK6XE6YoAAl/9AC3AxUxIaQE3Da/ketFCTF+YheHmV22ZvjJhN
 PHg2L6/kHKcGbBwlzAv/njkUUD4MhaMYTbwYZIE5sXSj2M04nkR2PQaW9doNKl6gNz
 Qyho6mk5yMZP+FBTh+yD03WTVNPq9PzJXB/88I/8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5C7FD940A91; Fri,  8 Feb 2019 12:13:23 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 11/12] arm64: dts: renesas: r8a774c0-cat874: Add pciec0 support
Date: Fri,  8 Feb 2019 12:13:20 +0100
Message-Id: <aaf6c75c0458122600a20db9d41a0350f0a8dff8.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623801.git.horms+renesas@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031705_843223_4AD40017 
X-CRM114-Status: UNSURE (   9.66  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Silicon Linux CAT 874 board has 2GB DDR memory. Update the dma-ranges
mapping for pciec0 node. Also declare pcie bus clock, since it is
generated on the CAT874 main board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 477a56b3273c..96ee0d2c6357 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -56,6 +56,15 @@
 	clock-frequency = <48000000>;
 };
 
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+};
+
+&pciec0 {
+	/* Map all possible DDR as inbound ranges */
+	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+};
+
 &pfc {
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
