Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:18:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C4D20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fUcucroS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C4D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dbeytCfY+uCcMXDlqd5CycnGsOBW8u8+fplkaatBMUg=; b=fUcucroSUkVLBfaSAoe+Qt5oq7
	gka7bsW8NeAKLNcJUFymGpg8NTXPXYEi+VbsAFkGUpgYcdIq+B9vbKLBnh+nPie6WB/r6bXpVMx98
	mRKTHp30gYkcJASCzeFaox89CrjTuKZldltujayXa8tSPFucszhZJjT4iW2F478zNExRzYieYnzkR
	nzUntLH41Bce3cm0nFB1VU4d3k+kQQg9bcTjEcSlBc69VPeTpMEJg+kaT/zPMtCH/4aM95fwxaXTW
	oQ7C6RIpyr3NeTqxrOH3ddOgT5UJgFjBmaXBiuBPK9eCFACe0ifXT9/R7ctyBZQhP+iIw765Tg9/E
	QZH6to+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8Vw-0002hH-QP; Thu, 03 Jan 2019 19:18:44 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8VI-0001yA-KF
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:18:16 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 lsun@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 3 Jan 2019 21:18:01 +0200
Received: from bu-lab53.mtbu.labs.mlnx (bu-lab53.mtbu.labs.mlnx [10.15.8.107])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x03JI0mO027204;
 Thu, 3 Jan 2019 21:18:01 +0200
Received: from bu-lab53.mtbu.labs.mlnx (localhost [127.0.0.1])
 by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7) with ESMTP id x03JI0Bm156099;
 Thu, 3 Jan 2019 14:18:00 -0500
Received: (from lsun@localhost)
 by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7/Submit) id x03JHxYd156098;
 Thu, 3 Jan 2019 14:17:59 -0500
From: Liming Sun <lsun@mellanox.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>,
 arm-soc <arm@kernel.org>
Subject: [PATCH v7 4/9] MAINTAINERS: Add entry for Mellanox Bluefield Soc
Date: Thu,  3 Jan 2019 14:17:17 -0500
Message-Id: <1546543042-156044-4-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546543042-156044-1-git-send-email-lsun@mellanox.com>
References: <1546543042-156044-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_111805_867827_ABFA6E80 
X-CRM114-Status: UNSURE (   6.52  )
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
Cc: devicetree@vger.kernel.org, Liming Sun <lsun@mellanox.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add maintainer information for Mellanox BlueField SoC.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f063443..bb2ea86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1759,6 +1759,14 @@ S:	Maintained
 F:	drivers/phy/mediatek/
 F:	Documentation/devicetree/bindings/phy/phy-mtk-*
 
+ARM/Mellanox BlueField SoC support
+M:	David Woods <dwoods@mellanox.com>
+M:	Liming Sun <lsun@mellanox.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/mellanox/*
+F:	Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
+
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
