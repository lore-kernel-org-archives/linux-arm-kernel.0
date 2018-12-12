Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A2FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:54:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0953520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n3amCxo+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="D486D8Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0953520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xSOIRVi6PgXrQTZR5Tz/4D3YloUVud18iRhJYKLiVb0=; b=n3a
	mCxo+i3uO+lhAU5LL1yturo8iXbZt9IPpIMjYyqg2H/WH03/EDAIBEEl4HD3Y0Tcccu0aA3U1abHl
	8dxGDckYbylvPHJsA7JvN5R9k50b54xLMN2/1Ps0rwI1qWA6IsyepM/lLDQp7hzHTFOMwPRK29ewQ
	Zdk7uwNdMdHLQNhyjWAAw6UYQh1roatNYlGbRGeNdFjY9GK3IkyU0jIe90jQCAVHNhZU0WpZ4I7gk
	j4YV7W/LpFjGCvDXgBRvdEFAkuh9jdP2B8qMp/5CVxWdw39q/GaY2X3NVD1fmcXN5iZ1UhVpZQnGn
	KQrygYw58AKkfjHkyoHl9pqhOY5pQ+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2AK-0002y1-Di; Wed, 12 Dec 2018 10:54:56 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2AH-0002lB-51
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:54:54 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BF3CA25B740;
 Wed, 12 Dec 2018 21:54:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544612082; bh=ezdPvSbf5zksIZHvtCKEf6zr/29Hou3VsrngMMcQMCE=;
 h=From:To:Cc:Subject:Date:From;
 b=D486D8NuGkflCu1ErR1Wbvnb1zHj2iPmpVVfrlLxMyJosWfGu8LqSdsE3wiscoLxx
 Vzg6xcJeH8Axp0MDBe+CXxV9r4R1B9leZOjeIVx1b/75ldGP9hNfNE/gOtR3Rw/6bv
 yb0b9DcQL6JtFoYVLiMiAR82jiKmYe2vEUK9aIz8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 20C359404C7; Wed, 12 Dec 2018 11:54:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH] ARM: shmobile: Add missing dts files to MAINTAINERS
Date: Wed, 12 Dec 2018 11:54:35 +0100
Message-Id: <20181212105435.28310-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_025453_342451_DCCCD152 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add some more patterns to the ARM/SHMOBILE ARM ARCHITECTURE
section of MAINTAINERS to complete the list of maintained dts files.

As of writing dts files covered are:
* arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
* arch/arm/boot/dts/iwg20d-q7-common.dtsi
* arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

 Based on renesas-devel-20181210-v4.20-rc6

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c7a08740cb7..2d4b90ffb14f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2075,6 +2075,8 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/boot/dts/emev2*
+F:	arch/arm/boot/dts/gr-peach*
+F:	arch/arm/boot/dts/iwg20d-q7*
 F:	arch/arm/boot/dts/r7s*
 F:	arch/arm/boot/dts/r8a*
 F:	arch/arm/boot/dts/r9a*
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
