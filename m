Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28EFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04C42133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SncUseR4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="pVdGsuDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04C42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NfSY6G4it//ySta9+K7/uLvyWsEl1/bCNt4UaoyQ8hE=; b=Snc
	UseR4FWZL6nS20IQqELXvRdybb6INMDKgmHfToLKuO9G/ogf3XXUqISZxQsjjjiFbAcrMOEb/se1x
	0stxijc6loadqEN23/f8CPOP6zz5mOTwHq9wLZ0wunkCfUGa8ubZIz41DkQ1K1fCe4P/GfcQH/a58
	8/lkhQrKSlwPQJIMp0gh5lt/Ve/aA7mFhH1+NHykk8Ig4dZJq9p/QLlmHF0coqvNBMeiegcQvdM/n
	O+5EYqvLOZB/8SHW0HlEg56e8pErkHW0mSe7Vbxp7tzeFb7/tKnizlOSlhFJUE+azm2nBRLbVIcyQ
	bt+oQPX+Sa7FnsdvKFXuDmZ+cJrGjcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXm6X-0001Ki-Nq; Fri, 14 Dec 2018 11:58:05 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXm5s-0000Tp-Fb
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:57:26 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B3CB225BEE0;
 Fri, 14 Dec 2018 22:56:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544788614; bh=Aapek9I7/5mxMQpRX3IxlZDpnsDCq3Jv+NXsKr7N7Sg=;
 h=From:To:Cc:Subject:Date:From;
 b=pVdGsuDAqp12ArjEVzc9CtA+rWywXjABiW+sUzdwSawVqZpf4G3Bl1SPTVAHiLewD
 BHxAJ+KXNhhr2qcX5vAqUamh1lLC5OcUENO6s3lUMk5SGHeG6YplNoSa8AvxOnJVyD
 xK9Z+jWBqlFtP7FsCGUlEdIrRWdXOLjAv1IZgrDE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 1A1559401C3; Fri, 14 Dec 2018 12:56:52 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
Date: Fri, 14 Dec 2018 12:56:49 +0100
Message-Id: <20181214115650.12443-2-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_035724_816629_ABEA08C3 
X-CRM114-Status: UNSURE (   8.30  )
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

Enable the scu-simple-card which is used by
the R-Car E3 (r8a77990) based Ebisu board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f88190463481..b521159f5f33 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -491,6 +491,7 @@ CONFIG_SND_SOC_RT5514=m
 CONFIG_SND_SOC_RT5514_SPI=m
 CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SIMPLE_SCU_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
 CONFIG_USB=y
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
