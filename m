Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:33:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AE62070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbPUYEnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AE62070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VO0Jb/XAqvmxTg+56iLDIBsjsf57lTACiUNrLZhcmb4=; b=NbPUYEnvo3ebT8
	+QD1H8/ygi86/1Nuh2g2BO4kotn2rETcS2lRPGbE6lcKs6JnEDyJ1JruXgsxgnPm8iFl0rIGPIDGf
	Att1Vy8W0zvKJtFG4XGDKJhOwaw0csv8qklfS+ZpJ6bOW6qE4tdNngw9USxR/4s1un16hwUxsRJfX
	Y2h5GKTQUUCX33dX4C1J8JxFBjeouU7JwP69TFkLLbFskhLv2g+oqrLe5LAGfV+UfeSiSPsY9D6wt
	/HAzKwTSK1jSUxtAh1LY12LLrN9WDmxNt1+m/q5K44c7vqwTwDkeeO3ENQcSXjg79fkSs5RtYc3TO
	xl3nzWY5rjaXI6piI0/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguJo-0000sr-Dn; Tue, 08 Jan 2019 16:33:32 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguI7-0007dH-S1
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:31:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 76DE1207A3; Tue,  8 Jan 2019 17:31:46 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id BA56F20A13;
 Tue,  8 Jan 2019 17:31:27 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 5/7] MAINTAINERS: phy: add entry for Armada 3700 COMPHY
 driver
Date: Tue,  8 Jan 2019 17:31:22 +0100
Message-Id: <20190108163124.6409-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108163124.6409-1-miquel.raynal@bootlin.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_083149_124871_B1B0BD69 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add myself as Armada 3700 COMPHY driver/bindings maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72e930c51fd4..2ef7a60ab24b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8865,6 +8865,12 @@ F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
+MARVELL ARMADA 3700 COMPHY DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <boris.brezillon@bootlin.com>
 M:	Arnaud Ebalard <arno@natisbad.org>
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
