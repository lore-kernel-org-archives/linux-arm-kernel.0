Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC24220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OKhuJbDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="lK6LaeKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC24220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=w076q1H6yO3PaK5kzG9jTBmzEq1sVbldQyZfR2TTx6o=; b=OKhuJbDcmnr/7sy0mb2dcyGG69
	ZJtn5hxgZRnr4shLrJaU3xe0xLtQkv8uST4VIDcthg/L9SguEos1GPsYHXVaYT/pAp1AaZ+KvA0/Q
	dywmRKLDqarASqH0dUWONH8vwJC5KTiMcfDcZoOOG6NnOkD3wEWy0QBueU0ljZ6lkFC9oMsRImTcZ
	zTcmJQZ4p+LOl8XdMGO+UzoTG7QpRFer+24d0QKVq1xO5oDzh9NbE82w2V+4sxkT9PgvNqNZ5Yrtj
	/6CnOlVg2MDgm5dTE3pDgZl9qrWWTL5mVLomNfG5SC04/Zc+2uD9pF1hLM0RGI7dzc7VYxxtSfUPp
	Kzcl+X3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Ag-0004mC-ST; Fri, 08 Feb 2019 11:18:14 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4AK-00084G-BE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:18:12 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E79B125BEEE;
 Fri,  8 Feb 2019 22:13:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624407; bh=+v8LbGepgXXGrXAHhv5pHJMMvAvgmP0tM5j61OMLMek=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lK6LaeKXsYX7hPUTwMX+lN9cnMNsyiHS6XXX9dp/09dkiiPFAGpWrX9f0HFfDtdlD
 RTZiDgu1GTVb8rnFDSv9M11/UnL2hNQooJYgy0qfhnV27O3MmGbFH4GCrDDybpZJhY
 jW+42ejFMp8tBCI5xzsZvCUukNhqa3DP1X/hwiQ8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 6D03F940ABA; Fri,  8 Feb 2019 12:13:23 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/12] arm64: dts: renesas: cat875: Enable PCIe support
Date: Fri,  8 Feb 2019 12:13:21 +0100
Message-Id: <ee20aeefb53f6ffabed5b1a3b859294197eeb351.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623801.git.horms+renesas@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031752_700618_9F2B231D 
X-CRM114-Status: UNSURE (   8.20  )
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

This patch enables PCIEC0 PCI express controller on the sub board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/cat875.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index 805ffa7fb67b..14db66755a89 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -30,6 +30,10 @@
 	};
 };
 
+&pciec0 {
+	status = "okay";
+};
+
 &pfc {
 	avb_pins: avb {
 		mux {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
