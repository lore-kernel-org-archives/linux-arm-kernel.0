Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3336C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D85F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e53qbDe1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kHcObFXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D85F21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UFSrn6cncew5ivaywTV8NcOOc5KPnesMgP7EWxNQOqQ=; b=e53qbDe1QiA6UECWYla8UqslxK
	FrwaCI4TomkqGOPZsS0GOCC8PQe4mTi9oYbLIlpKBjUFYw8fJIcVJysje0eazft1w8dfcrmobk/Gy
	LuqgiCzhx+yYXqtDNLGqs/xskHLA8A1vAZO0jzMdgg+x4u8AqXNB5gUSe3mAAdUdrIh57tI5Pt7+c
	YHT8nJyHddgI2ar6ziUGWJoXgBOqQnpyNb+lEoL/Q1tPNeuPSoq0JWZjPmeAp6aFXGsR2U6oSsrqI
	kPhcUMPnoEK+s9gDEPpVVgDI+YXR7c1FncGLLLoNKYZqgcxdB/PPk2loEiQMt+V700v0tGeBmw8pG
	C6wAKzeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgtU-0007l3-Cp; Thu, 24 Jan 2019 15:26:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgqD-0007Ii-MF
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:22:55 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5287525BF10;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342765; bh=uUf+SCZINUCWcypl+uPU6k47SwFXZFf+G9sywp6Szak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kHcObFXkJ1XqiEFFXLl80EhIT5GNBvY0eIPpZfN09gR/PCFE+tNIXi4Mbek8BzLdj
 GGAB2dAhJ2aXmOF9az0T/4nwLgcvHVDzARiVmqpGK906W+s5qPrg3LaJQvY82Eczex
 e6RyNRFitIwlP6z1lS+YaFudNMFU2kNJ7r9sRfZo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id B5C76940E6D; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 44/44] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Date: Thu, 24 Jan 2019 16:12:38 +0100
Message-Id: <3e279a1d44d73aea9ce428ae68e76bf85117031a.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072254_128381_E6541407 
X-CRM114-Status: UNSURE (   9.56  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable HS400 of SDHI3 using the corresponding DT property.
No further changes are required.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 89383aa35d65..144c0820cf60 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -695,6 +695,7 @@
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_1p8v>;
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
