Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6912C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:04:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8548F218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nO3QCjDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548F218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oZcu6PIDy3RzVK2HN7HeeWVL06dgDEyaGS186vr5Mss=; b=nO3QCjDoEkD/Fc
	dWghHKxEVaZOU/21pd97H28KIyWKfzeySyXIhf64eDPtlfqwMyWYObNtAVtxMeGMWWfmNuHsv6eKs
	c3jrSs3FYkWgXnWEIrnIwWxTsVMFlDAIOVdq+kb9G5cNsPlvGG6A/2ax62mzP6f7GPQyZmCkT1oOS
	PO7e/6Iem+AJ5txIWukBPLrkpGaNilJsbFX2wuy2cknii3m3yIW9wim9iJdjAvy/PShxOw3Oaax9j
	dLphBfjaRHfBG9xoUDRoMyrQ5ruJEy62VgTZF+J9QdqwbhYJfy1H48eya7pD5NpnpUTCKqajMMcib
	WV9GK5BnoW67qAk2Qj9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn9Zv-0008Iz-PN; Fri, 25 Jan 2019 22:03:59 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn9Zr-0008Hx-Rf
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 22:03:57 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 225D1389B29;
 Fri, 25 Jan 2019 22:03:52 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] ARM: defconfig: lpc32xx: enable NFSv4 support
Date: Sat, 26 Jan 2019 00:03:43 +0200
Message-Id: <20190125220348.5357-2-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125220348.5357-1-vz@mleia.com>
References: <20190125220348.5357-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190125_220352_160422_9E107CA8 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_220352_160422_9E107CA8 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The change allows to mount rootfs shared on an NFSv4 server.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/configs/lpc32xx_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 6cf9ebb17274..2e1611578c61 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -177,6 +177,9 @@ CONFIG_JFFS2_FS_WBUF_VERIFY=y
 CONFIG_UBIFS_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
