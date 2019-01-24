Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C186C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F685218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YNyPkUx6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ZYYqaU9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F685218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nyP54maLFM57J15/RITbYpguTtKnKKyQgNypDThzFvQ=; b=YNyPkUx6RC9R6YpMogcwohMhVd
	kJX3QMlCdc3bQ0P7BKSE8tSeirYGuVHiw+GiyKLlS4CKj7f9W8P/uc3qyuEl98o7LE1vZu0LYzbOz
	AKhGfRpEgxAlTYqfEhLlZCfpEO2BFgywyN1oLcKJa5wQDf2vEA6RasjS+qOKaD0CNhuBh21iIxNKQ
	wdXn5XjanSZe9V+FoxkjmVJUvyZylF2CoOM3p57jFKJpucl+b2Lbpoz8yxc54Rbj2csmh8edOkk5g
	5/YRTB3sCpB0PjuxcVqy97pGOgGt5axbQU4jQKwiMFThE6cMIzeZPXz+MNtweLA4QHLG1p6d8Sa6N
	omXYK1KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgsz-0007FQ-Rf; Thu, 24 Jan 2019 15:25:45 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgpo-0007Ii-Nu
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:22:43 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4C75025BF0A;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342765; bh=bsdi+ynj+kAAoK2XbcizzMweSNBssSGNNwoDUYrhwXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZYYqaU9XxgIuI7WpkkQdvWvKS3e1+H+6cLyOJKX+b2CKLy7yTX30VGO0IaPwhuVk5
 43ddwCrYDuFxUnVjGjxklNiZOwx1mBbzHSx6hOMK3BZLozvki9pm0STvy9yXvmVje0
 z0UeFkEjgON9AtQkejxfWUvXrZhh7vd0hIBc3j1s=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 82163940E45; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 41/44] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
Date: Thu, 24 Jan 2019 16:12:35 +0100
Message-Id: <12105cec654cf90648f65f7dc90d1be982d326eb.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072229_610366_ED90965B 
X-CRM114-Status: GOOD (  11.15  )
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
 Marek Vasut <marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
the eMMC and one 12V for the backlight. This causes one to be overwritten
by the other, ultimatelly resulting in inoperable eMMC, which depends on
the former. Fix this by renumbering the backlight regulator to regulator2.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reported-by: Simon Horman <horms+renesas@verge.net.au>
Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index e0590c0af4c4..89383aa35d65 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -191,7 +191,7 @@
 		clock-frequency = <24576000>;
 	};
 
-	reg_12p0v: regulator1 {
+	reg_12p0v: regulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "D12.0V";
 		regulator-min-microvolt = <12000000>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
