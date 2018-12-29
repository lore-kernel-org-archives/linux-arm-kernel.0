Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60961C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3152A218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ngdMnpFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3152A218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1Dd/wXxTjm6zy8nChIawSBteiGa6apBfFoiFuL+axX0=; b=ngd
	MnpFKRRXkJcXOO+RMiXMykuYxc7NHZTfDXlts6/Z1qQ9COz68JtvxGXCBT83gYqYmXre6tjQrLagY
	EmHrPcXZlBOQmHxqSjtUcF+KEtQxQj9guWyoCMtv/VVo4r3dYbkCp81+fXyjYOzGu1rNFubsL9BQ9
	OcFWBsj0mQ3JfVUxwA1aRJa5lwJV07p4LM5X60HDhnvr/kDC3OWroej9N3DRgh2gwfJhCE8KF2qtw
	zm9omozfGSmK2pB5YGNEbkES4lhNr6SBQWSHe+ES2nIE2Hld87W/5DZ9vmnoAxpAod+24ordfnGac
	l5OvD4w59TumM5Uj4KmIWQJ47SpqKsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd6ZI-0008QM-VC; Sat, 29 Dec 2018 04:49:48 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd6ZE-0008Pi-UK
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 04:49:46 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 48F89428036E7A616BD1;
 Sat, 29 Dec 2018 12:49:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBT4nNa7078110;
 Sat, 29 Dec 2018 12:49:23 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018122912500712-19455304 ;
 Sat, 29 Dec 2018 12:50:07 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: linux@armlinux.org.uk, robert.jarzmik@free.fr
Subject: [PATCH 2/2] arm/plat-pxa/ssp : unneeded to free devm_ allocated data
Date: Sat, 29 Dec 2018 13:10:06 +0800
Message-Id: <1546060206-97556-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-29 12:50:07,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-29 12:49:03, Serialize complete at 2018-12-29 12:49:03
X-MAIL: mse01.zte.com.cn wBT4nNa7078110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_204945_137783_B4FE6710 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Peng Hao <peng.hao2@zte.com.cn>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

devm_ allocated data will be automatically freed. The free
of devm_ allocated data is invalid.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/plat-pxa/ssp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ed36dca..f519199 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -190,8 +190,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	if (ssp == NULL)
 		return -ENODEV;
 
-	iounmap(ssp->mmio_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
@@ -201,7 +199,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
