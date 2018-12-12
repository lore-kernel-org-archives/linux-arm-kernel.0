Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C75C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4974220839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bfx3WT8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4974220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zq2xx88HNtUQM1rWcrxkVJpF6UoGanKw8Kg0a5Xg/y4=; b=bfx3WT8jHcc5lg
	viWf78IrjYbZSmxEbG7AKhXZDvKsUWuo1n1yhUrEDVJId0L3+4o7JKKE/NMoTLtO/DswgBeDuRmkN
	Hg8Sqyiw/A1q/kBMcrpMfPNsSmhTEz3HHtjHGJ72evh9tP/mx66wydTOz8PLJFvPQEj7kVA/Nlu1F
	YMNdCtpV9EC2ZX274zEohQAscZs0bDq4bbLlYHwRJiV0TqUIrguD8yO09CHS0U6z6Q7eI36MtO0/2
	pQT+ocyM9hVVWSP07+LEEQ0lKPk9k7a4q68bSgn8XbeL5tNOwIlq1+Dsususo5Cj3fldU1jypMlrv
	TM64zLZJFXl8q9RdStMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2CX-00053W-UF; Wed, 12 Dec 2018 10:57:13 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2CU-00052J-Kj; Wed, 12 Dec 2018 10:57:12 +0000
X-UUID: e75b33134e604f8288fe585d2bd6fb8e-20181212
X-UUID: e75b33134e604f8288fe585d2bd6fb8e-20181212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 446859826; Wed, 12 Dec 2018 18:56:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 18:56:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 12 Dec 2018 18:56:51 +0800
From: Miles Chen <miles.chen@mediatek.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
Date: Wed, 12 Dec 2018 18:56:49 +0800
Message-ID: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5C17EFA49BFC5B10294428546CA39A4491BDC7A3175BB255EF1A6BC31283A15A2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_025710_805291_9C7486E5 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: Miles Chen <miles.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wsd_upstream@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
perform linear virtual address to physical address translation.
Sometimes we're debugging with only few information such as a kernel log
and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.

Tested by:
echo c > /proc/sysrq-trigger
[   11.996161] SMP: stopping secondary CPUs
[   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
[   11.996881] PHYS_OFFSET: 0xffffffeb40000000

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4b0e1231625c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
 		pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
 			 offset, KIMAGE_VADDR);
+		pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
 	} else {
 		pr_emerg("Kernel Offset: disabled\n");
 	}
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
