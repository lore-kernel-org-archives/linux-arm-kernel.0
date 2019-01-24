Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C50C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DBC218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlBC/XGS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ekfjKqFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DBC218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ssnSQ8NzHq1bB/k0dGo1jjkzjWJJ4kbD/9mTv+EzhGs=; b=nlBC/XGSUwdFd947M23H5KxXpi
	vnNJUWACW5rXZmpO6cighwOoG13fMKiiOfZODfQ14hNBWcS7hs7m7dFzllaNcg+GxibxgnUDd7IFj
	IF8JOq6QuSY2pz+FJ6+Z9Ex/P4e/9bsaymCgYNIkX5WpFqRblL1ia/EKbgS+8pHhzvtbYGdZdVNQ7
	Az5BRMURF5S46faqY0k3ldNJaRlg8TWJtG4UDlIR4VbqFZScfidb7/1TlSgGfsby2f760C6ZZFuGC
	ratQF8oGorivbFkJZXn8CjURHsmkeOhf4M9IANIaH/vxYSR+p15FZbxXheQUFUf5keIi7pCxVGK8X
	/NOnZpLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgsW-0006BS-1z; Thu, 24 Jan 2019 15:25:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgpD-0007Ii-6K
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:22:28 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 493BC25BF09;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342765; bh=m9wr3n27o8TRMpJOQgtwEoTEiiImT/awXySBMbYEpag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ekfjKqFg8pAL8VqcYTQfrbps01zHaVUR2TQ5YeWO+k+mBTJAvE8wDayWgbqFvIQf1
 /rqhyihOcxzHLUGA7ArblIU5F5p+ssmv3enXuzSd1kyFyC6aKeHaetV6fH1TDXgrJd
 x58FJYBv/uhKBwC2LTDi6IoJAWCnbDmAhgG2QXkQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 73AF9940E4C; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 40/44] arm64: dts: renesas: v3msk: specify EtherAVB PHY IRQ
Date: Thu, 24 Jan 2019 16:12:34 +0100
Message-Id: <d5e5790c6ff0b6825f6d8b4baf67fa13810ce4fc.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072152_011653_01245C79 
X-CRM114-Status: UNSURE (   9.09  )
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
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Specify EtherAVB PHY IRQ in the V3M Starter Kit board's device tree, now
that we have the GPIO support (previously phylib had to resort to polling).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index 0dbcb4cccc18..15cc9fed2e16 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -108,6 +108,8 @@
 	phy0: ethernet-phy@0 {
 		rxc-skew-ps = <1500>;
 		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
