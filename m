Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCC22176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duJaKpbZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="boy2rsnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCC22176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7PyAqmpRCdlW5JMT3y/ky/JQ4rzVt76lFMbisXMzaJ0=; b=duJaKpbZJ3h+D752FUfuN1yAmN
	eHO6oSoCsBmVZDfsv6LcPi+wMOLJNVFXkijqRcLkYw2LEKUCaOXX12akZW1HDYrYd8enBvqOVjEQY
	UxFOtxkLZK7q+wsiDLNqKBZk8VbheYVrTXp3VLO34oAGKZxkuh9rqitRY4wFhMKQCagWzcHbSE7eW
	NY76tiUpy4po83MgorCOYiXeHxZZTJ94XjzPSLOZ/9clVJRFobJT3FmqrYDsHRC1vim9d9a9VRp/y
	Nx7f4JJl3ci4VxenK72WbtnxgQiy28hrqIVWdTQcE6Sms2jm96GQLf1OpbOLdMmq3Pud5dPVlJtE7
	FgbPjKUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgTy-0008CC-NG; Mon, 18 Feb 2019 10:49:06 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgTU-0007Tx-RI
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:48:39 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C80E925BEDA;
 Mon, 18 Feb 2019 21:48:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550486904; bh=F3cCUCLMmHYfgbDN9NlFeyvUSJy2jx37FQe1yMcCG6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=boy2rsnJRuRrYGsI3WrMuTETiNXwKvmpsGoXanvAaEI6O+gKYZoecYqJtfJe7Ebz3
 ea9BrdVVxhdaTI5D7q9ahP9cvczMWnT+kzncnI/lTWoVsiB4LrHYZsu0KlE8AqjQBy
 dxs/eeHBAv4iz9xmRARIguSEJYqLlCk7MWq4vYY0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id BF9D6E218D1; Mon, 18 Feb 2019 11:48:07 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: renesas: Add si-linux cat87[45] boards
Date: Mon, 18 Feb 2019 11:48:04 +0100
Message-Id: <1a69a73c9b006ae72e06a5e637932bfe2fb7bc05.1549624030.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549624030.git.horms+renesas@verge.net.au>
References: <cover.1549624030.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024837_525897_A4FDA742 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds board cat874 (powered by the RZ/G2E) and board
cat875 (that sits on top of cat874). Both boards are made by
Silicon Linux.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 5e9d4864a600..9e1e07b5192e 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -108,6 +108,14 @@ properties:
 
       - description: RZ/G2E (R8A774C0)
         items:
+          - enum:
+              - si-linux,cat874 # Silicon Linux RZ/G2E 96board platform (CAT874)
+          - const: renesas,r8a774c0
+
+      - items:
+          - enum:
+              - si-linux,cat875 # Silicon Linux sub board for CAT874 (CAT875)
+          - const: si-linux,cat874
           - const: renesas,r8a774c0
 
       - description: R-Car M1A (R8A77781)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
