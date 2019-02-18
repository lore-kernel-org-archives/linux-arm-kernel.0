Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF837C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0702176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KeLLvc7u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Dn/D/Y0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0702176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yZM4fqEllYaTv5ZzExSOzlv/azEZSXX3aIALRhqQ0Tg=; b=KeLLvc7u/MyzqrcUyKsZp6zZHA
	IIlUKxQxc0DCRkwma5Qh03rPSPXCU9fSIsI1dPQ+S2HA1jiisnJwE6F2yrD5ONKa8P4WGanyj29jS
	x5Fj0OoGJA/+2UfDyaww4t95FuKDJ87H5m20RejXwRa6mmlz3bfPByM21YJD6iGWr/vU2FHkApTts
	Jh8U16zNp/xmP477fN1Bq86/rdVf/SS26YOmx8SQg1cmEnTXTxoiY8qVry8c8nL7WaZ3qWfazkCSv
	cuak1NK0D8HgTTOODGt3rsOhazGPGEujlH4eHroiDQb3PdpZWBI7UulPAh9hqP+uXlY37lyK+NCOA
	mQ26vJAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgU9-0008Qs-EQ; Mon, 18 Feb 2019 10:49:17 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgTX-0007Tx-EX
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:48:41 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8158125BEAC;
 Mon, 18 Feb 2019 21:48:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550486906; bh=ywfXuCMYMMxno5H1hvjTQde5VmOUreRVvV6jPD6zTf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dn/D/Y0ARJtLdqNwSNCjwQKMIn1hop/7vsIEiQmCfcBnb7ydGrDfmhjf+e2yLJt3/
 OXwA7HmSYjq22iXwaLUbuAIyCRfVcdITQwz/jUMqTbFvd/XNcS+ZKc3/ocgq/suLtE
 StWBRa7vBuRIV3HNn8nVM2amyadX7C5Q2Dpc3jis=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C3956E218D3; Mon, 18 Feb 2019 11:48:07 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: renesas: Document RZ/A2M EVB
Date: Mon, 18 Feb 2019 11:48:05 +0100
Message-Id: <58097b0e05c0dc70345c02cd83117f134574024e.1549624030.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549624030.git.horms+renesas@verge.net.au>
References: <cover.1549624030.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024839_674990_0D48DAD0 
X-CRM114-Status: UNSURE (   8.54  )
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
 Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add the RZ/A2M Evaluation board.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 9e1e07b5192e..cb9b4417e8a1 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -30,6 +30,8 @@ properties:
 
       - description: RZ/A2 (R7S9210)
         items:
+          - enum:
+              - renesas,rza2mevb # RZ/A2M Eval Board (RTK7921053S00000BE)
           - const: renesas,r7s9210
 
       - description: SH-Mobile AG5 (R8A73A00/SH73A0)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
