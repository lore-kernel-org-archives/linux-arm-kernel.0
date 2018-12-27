Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E277C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D45E214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5vv4GmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D45E214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XfTiDq+uAsFHtITmuhsGDpkRmQh1LcOvVKbHUCU1md8=; b=c5v
	v4GmWsff19YN39+DUj1ipZkdubDMXQEpd350VYyi1TuKnNvo2J6jLPHNObAP5FyoCV69008NO32zC
	nofyNjCP+h08L0fbk9YfhHqLIvUt0ymwH71ZV7JyuO34zprb/S6vxRa8bldB5MkTiiEpRXT8fG8tz
	Xqg/ClaVEAGRwtWogwUlkZJWSFe3ysc88clxBwxfPeZAUgG2zOXm4XcsMeVMVl/2bf+WIlQuGtDFa
	3jsimsexpLeJkm/T3bo0JV9ZJv7BF+yxgnOT6lRE2uEHFx7BpBru+MGPzVRnE8g8gioXkU6AZNM9r
	d5vF7/WGj6pgxeKj0Ao6K5gw9GtY8Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOmM-0001Mm-Ia; Thu, 27 Dec 2018 06:04:22 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOmG-0001Lk-Ag
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:04:20 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 24C143B91CE20114F429;
 Thu, 27 Dec 2018 14:03:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBR63ouw019580;
 Thu, 27 Dec 2018 14:03:50 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018122714041906-19047302 ;
 Thu, 27 Dec 2018 14:04:19 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: linux@armlinux.org.uk
Subject: [PATCH]  arm/mach-iop13xx: remove duplicated argument in define
Date: Thu, 27 Dec 2018 14:24:33 +0800
Message-Id: <1545891873-84150-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-27 14:04:19,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-27 14:03:38, Serialize complete at 2018-12-27 14:03:38
X-MAIL: mse01.zte.com.cn wBR63ouw019580
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_220416_528068_713C5C1B 
X-CRM114-Status: GOOD (  10.06  )
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

Remove duplicated PCI_STATUS_REC_TARGET_ABORT.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mach-iop13xx/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index 736168d..c6a0678 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -23,7 +23,6 @@
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
 			       PCI_STATUS_REC_MASTER_ABORT | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
 	 		       PCI_STATUS_DETECTED_PARITY)
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
