Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF6B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duWH+j2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF6B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KRujP55ciGcsOPDvDTj1uc5wqwBKiT6u297p58d80gQ=; b=duWH+j2SgHYnGj
	brLw+RbPh/KdJLk1G7zKJ0cr8aRZAHzefIGOSqVlWMoYmn0jSd9P5nI45LO4vYmArX7DCQiTjV+VD
	0m87ZJ9IuQSYl7c8LdTo+Fl8QMpYpgs1ANiqQHwRbNvP93Yurbb/TGvvh6an3AWDKtisFrzZaEKjz
	9yO5Qatk+CLEvgITQ7IJp6/bUtSSV3eOCyEnaA7gJGS4si//yUohrnk32hhtSBccfg4kocMzw0y/I
	lloH8mZPY/Rx3TZCDVsc/x2gOpzYZj8iLdM1DbU8QrRi9+mWBm8QgE3cM47CfoNV6J4v3S/We6dR5
	J/DzljlF+7bQOeJ6BP8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2jR-0003WY-9Z; Mon, 14 Jan 2019 13:56:49 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2jN-0003Vu-9z
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:56:46 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 9B8FB18325;
 Mon, 14 Jan 2019 14:56:41 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id KwB4J9zAMyFI; Mon, 14 Jan 2019 14:56:41 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 155A2183C7;
 Mon, 14 Jan 2019 14:56:41 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA7FB1E07D;
 Mon, 14 Jan 2019 14:56:40 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF2B31E07C;
 Mon, 14 Jan 2019 14:56:40 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP;
 Mon, 14 Jan 2019 14:56:40 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by seth.se.axis.com (Postfix) with ESMTP id D2F24F4A;
 Mon, 14 Jan 2019 14:56:40 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id CE1C58099B; Mon, 14 Jan 2019 14:56:40 +0100 (CET)
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: linux@armlinux.org.uk
Subject: [PATCH] ARM: Implement pgprot_device()
Date: Mon, 14 Jan 2019 14:56:38 +0100
Message-Id: <20190114135638.13520-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_055645_510778_A3484869 
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
Cc: Vincent Whitchurch <rabinv@axis.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is used when mmapping the PCI resource* files in sys.  Because ARM
currently lacks an implementation of pgprot_device(), it falls back to
pgprot_uncached() (Strongly Ordered), but we should be able to use
Device memory instead.

Doing this speeds up large writes to the resource files by about 40% on
one of my systems.  It also ensures that mmaps on these resources use
the same memory type as ioremap().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/arm/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a757401129f9..48ce1b19069b 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -125,6 +125,9 @@ extern pgprot_t		pgprot_s2_device;
 #define pgprot_stronglyordered(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
 
+#define pgprot_device(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_DEV_SHARED | L_PTE_SHARED | L_PTE_DIRTY | L_PTE_XN)
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE | L_PTE_XN)
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
