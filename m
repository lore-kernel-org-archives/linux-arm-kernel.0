Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5676C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:15:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936AC20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMI+cZeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936AC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRpt7B6Vj1wbUrrx3XbrsKi0QC1ZJzc+uJzWtJT8SY4=; b=cMI+cZeKKiEJrc
	ebcOvR4yFCa/uliHINFL6bCO/T4gLycZhBk68STAZAfDNQNJHGWM5H9ygt7f01U8JJcYqi55GY/7/
	nT3UGThAyOi6EK0e5kNz1LVmOtcFHGThARypLLTRXjjT1klQjGwKFpFJc0s/xnDtPRSV2B8l+rQ/k
	KF0oBx1U8CKkx59gWuUA3QYeE6H7ofvoskLKKGkhAR7r1Caw1wKOinCBsQtBPRw0GuulIDUqRBrHV
	W0Frz5pPMGKA64e+48YpayF5ulnOOMeUzBuFXRthzdCy3LQ/TqVj+2905a5nX3/GUGM/4PAKV6niH
	Mi7n/CERdUK7UVgPdPig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2ow-0007oK-3x; Thu, 31 Jan 2019 03:15:18 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2nj-0006To-54; Thu, 31 Jan 2019 03:14:19 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:91f])
 by kozue.soulik.info (Postfix) with ESMTPA id F191B1018BD;
 Thu, 31 Jan 2019 12:15:12 +0900 (JST)
From: ayaka <ayaka@soulik.info>
To: linux-media@vger.kernel.org
Subject: [PATCH 4/4] staging: video: rockchip: add video codec
Date: Thu, 31 Jan 2019 11:13:33 +0800
Message-Id: <20190131031333.11905-5-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131031333.11905-1-ayaka@soulik.info>
References: <20190131031333.11905-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191403_728447_3D51CDC0 
X-CRM114-Status: UNSURE (   5.46  )
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
Cc: hverkuil@xs4all.nl, acourbot@chromium.org, maxime.ripard@bootlin.com,
 joro@8bytes.org, Randy Li <ayaka@soulik.info>, randy.li@rock-chips.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, nicolas@ndufresne.ca,
 paul.kocialkowski@bootlin.com, linux-rockchip@lists.infradead.org,
 thomas.petazzoni@bootlin.com, mchehab@kernel.org, ezequiel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Randy Li <ayaka@soulik.info>

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/staging/Kconfig  | 2 ++
 drivers/staging/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e4f608815c05..81634dd0a283 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -122,4 +122,6 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/erofs/Kconfig"
 
+source "drivers/staging/rockchip-mpp/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 5868631e8f1b..22499c68c21e 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
+obj-$(CONFIG_ROCKCHIP_MPP_SERVICE)	+= rockchip-mpp/
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
