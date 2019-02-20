Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315D620880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTL2QmKx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QzNS0q5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315D620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gMc24S+u/2oZuOtJ0XikwN6NKOn6RJi5y5OPAp5pFVY=; b=iTL2QmKxaa+odR
	WGaP3bvAPL5VlOV55oEiwLBt52hzxgMtKsk38/Gglk1T38yOq+1GwDRL9DEg24DtkYtgseI25MSPu
	1vGfwxqKGlL7fJtNM/RiXJ6ciZuVuCFvE0NFcZEhFM3P//iwf/9dt8AG2UJZ5+1J9zQ0fekCXYts/
	qn9q/KFSlHk0kalfOfkWpCue2yqfHJrvY8/haf6Z9A1rLJoCA1hEQ/hTyooaQgJBMbbuQ1IhN00tS
	qr+MhrM6xadQR1SBeWxw38xcpm1CUZxSphmmTJkUlv4sW7AYjYMV3AlofOW0GchE2RMaDycefxLoa
	0zPpBri/xtxHApUBloIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTmA-00014J-Gv; Wed, 20 Feb 2019 15:27:10 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTlA-0008Ez-WB
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:26:12 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFQ6Yp055615;
 Wed, 20 Feb 2019 09:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550676366;
 bh=soHH5poEO7ca8kvQgbJfShmQkZiM0uE0tzRZPtn/RYg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QzNS0q5IPXL9oU/6kxfOdHmYa6S+d1JL5SXnmOtsGyCRZnxs/fwguTOgEETOl/msv
 IQ3NCWvpOk14cP5hgozeUQcziYtqTZ/u7U2OwLbW/bYMGgLouLjyMeCsvNqPPNHCJp
 llRWtXz0lHhyX1nUQqHEnc+9hfyvQ5287sTdLDWE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFQ6x6085427
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 09:26:06 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:26:05 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:26:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFQ4ql006629;
 Wed, 20 Feb 2019 09:26:05 -0600
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I
 <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>
Subject: [PATCH 5/6] dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
Date: Wed, 20 Feb 2019 17:25:18 +0200
Message-ID: <1550676319-6440-6-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072609_816194_5F469BC8 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
deprecate cpsw-phy-sel bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
index 764c0c79b43d..5d76f991c027 100644
--- a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
+++ b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
@@ -1,4 +1,4 @@
-TI CPSW Phy mode Selection Device Tree Bindings
+TI CPSW Phy mode Selection Device Tree Bindings (DEPRECATED)
 -----------------------------------------------
 
 Required properties:
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
