Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D192070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ldmmu/KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D192070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilka.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wp8Z7M2csfIRpwRCEtkTQFS+9eay2Jw2XB4JiBc8Ccw=; b=Ldmmu/KDM5jW3i
	VLSkryAlBHMh+e38u/g3WwPkWP2Zoes4/dODRsTBaN7roU+kWptK0Ia32+Z8dW9nIG9MAo/d1R3yf
	hK5mOr1zcXxvQv8joIomksJKasrfTHtiAQBV2636F8ppJgKhXKLSzZqct06KWTjs2BKL/alCendKC
	EYNbSZlEdAiUFrzmLyrU88go2ajLWJsnzoXHpxtU6Qa1h24Fz6G8L7U4SVl7962r8hLbvfOvYYad0
	7kAmHZ/y/J/HWJhWUaXfkp7eSmJvDW4RIvLUaVEisqsVnTkQB76sF2X9loAkFIsFv+9IpBx59gVjg
	8Ubg0C2ymOXLdOaCvRGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt4ZY-0003t0-5l; Mon, 11 Feb 2019 05:56:04 +0000
Received: from bbb.xilka.com ([2001:470:1f11:5a5:16da:e9ff:fe11:e54b]
 helo=xilka.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt4ZV-0002Qh-H1
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 05:56:03 +0000
Received: from bbb.internal (localhost.localdomain [IPv6:0:0:0:0:0:0:0:1])
 by xilka.com (8.15.2/8.15.2) with ESMTP id x1B5rtea022225;
 Sun, 10 Feb 2019 22:53:57 -0700
From: Kelly Anderson <kelly@xilka.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] add mx24u3235f spi-nor as used by expressobin-v7
Date: Sun, 10 Feb 2019 22:53:49 -0700
Message-Id: <20190211055350.22181-2-kelly@xilka.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211055350.22181-1-kelly@xilka.com>
References: <20190211055350.22181-1-kelly@xilka.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_215601_842722_965B908F 
X-CRM114-Status: UNSURE (   7.84  )
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
Cc: Kelly Anderson <kelly@xilka.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Kelly Anderson <kelly@xilka.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd1aaa5..93c4e22e7dc9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1838,6 +1838,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
 	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
 	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
+	{ "mx25u3235f",  INFO(0xc22536, 0, 64 * 1024,  64, SECT_4K) },
 	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
 	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
 	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
