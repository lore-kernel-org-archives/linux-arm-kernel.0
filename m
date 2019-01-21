Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DDC7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:26:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C635220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YeFFbjZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C635220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HE4SXwGqwFdfrbmraq0qV0wn2vct38T+YkESBzlHZqM=; b=YeFFbjZuH+7Vov
	7V2wi39COpBltOR78zWQoWNKJs5z3k+QImlqs2/mSHD91vkLlEXxOJGuQAPjXJrp7FOiKQDe0L/zz
	rhCfcenk5YAnp8LzzXmck4bb4AmrJXoDutlrVUmg6clZGnez5GmQ+NIF5S32Es5oSHHy3HhvA80Nw
	42LEN0IRGLhTZG3xbthVBMYFKyn2H2V00TuPwRf12vRw+ZHr7KCrbAizlN4JXBlQeUNiSUa2r0A4X
	7KtDcQW+ajicbxWB6cpLZbANPoFb+TWBt7bG0egPif6eMSljSFgEc5UjRiu6JdricuVakKjXfzFuv
	lvin1WULJFcfZ+SYa9/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXjD-0005UF-5q; Mon, 21 Jan 2019 11:26:55 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXg6-0001Ha-4N
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:23:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 85A7720A85; Mon, 21 Jan 2019 12:23:40 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 21645206DC;
 Mon, 21 Jan 2019 12:23:40 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 07/10] MAINTAINERS: phy: fill Armada 3700 PHY drivers entry
Date: Mon, 21 Jan 2019 12:23:33 +0100
Message-Id: <20190121112336.23489-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121112336.23489-1-miquel.raynal@bootlin.com>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032342_306680_B7D55EB1 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update the Armada 3700 PHY drivers entry with the recently added UTMI
PHY driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abfd80f21b24..2a08a097e107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9080,11 +9080,13 @@ F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
-MARVELL ARMADA 3700 COMPHY DRIVER
+MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
 F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <bbrezillon@kernel.org>
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
