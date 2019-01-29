Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D80C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466BD20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SEjkMtm0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Z2U+FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466BD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Bw+IbI+aOO66vrs9IB6eNQlsqzJdzGW3+CG1b8iW95k=; b=SEjkMtm0kQBbRg
	93d3ZWuBXrdNVTjDj5EuI1HPSEr5WipFJTE+G8SzIYtERaAd2z6tGz7mfkoHCvzeXxShF5xWIScTI
	5r6OHmBQVfoNKfj+DCOTWbq2ZwPMTkegd6JlS7aGMcp9b1ASlSLjqO4RsGjbmo/7FQH97cIOl8Iff
	fLuk6UXNHPkPThMexs8LbsxcLymZqM8JzWxR5PsE46YSIgig+W3YQYgkAEgkncrqVWF/jz1HtTlW5
	BMa6+tEybYSw34VFP2cjD9ObvNf0SqUTenB7agDADgH9tetT/rQk66awPUBMSRMmxuO5qczzSx95N
	WOXggyJIMksSevN61Paw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobDz-0000ZI-9g; Tue, 29 Jan 2019 21:47:19 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobDn-0000Nc-4m; Tue, 29 Jan 2019 21:47:08 +0000
Received: by mail-ed1-x544.google.com with SMTP id b3so17372731ede.1;
 Tue, 29 Jan 2019 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8XV4iq9rA+fxnqZgdrOpJNvxbAjFgBIFBi+69D7N30=;
 b=O1Z2U+FFs/xXdhyfCIX4vQ/y60cjlT6HDkQbbCzsFOYaAYRvGEkqWzMxH11eUvLywW
 gBC+m1/yoJuwnGH7V1gi5rIVNPCWa+nNl1hC7Sd+KBIMIbbX5SBL+9onypPIPsR2noru
 HnKTU1rdKKgFWt+ypI5KA39EYIQyXaSjgBiBKTTmFcXMgPw5MJCzTEJs+z790N1/x+8t
 +S2rcqQ3F+CTQvGHasCuk7VWgQGkoerq+fzYx2HRoIETjKXC/Lq6o+vIH07RMxm/o1b9
 m7r70uUp9Gw+59LBw9u7Q5j8kOD7XcvLQlSqTqs3L8PuLVaZqZ0rPG10CIHFAtvwhSXD
 +BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8XV4iq9rA+fxnqZgdrOpJNvxbAjFgBIFBi+69D7N30=;
 b=GuZrZwNsowWznfwlPWjsmHOzPTOqCFjOIOx2lUQrQUtgLOnmURCkxhhjjwaJK1kn8R
 u8bOYtsIVP+uXVj+6eJqILFCxZ5Fakhw0Dmf8QqndBKtjru5wmWOseTZCtszzJapRzmF
 W3QlPf0sggnqfQA1xPa4nnoQjQAapezEhJZuLNnsU6P7+bCNWNrrYl1aFusoP2gMSMen
 YiHCL4iZ0Nydq+j0Fr5FBJ1uPrYoFfU7C3aIzTTak5Lv11iAcq7A0xA5R3UuX3DlVmOH
 UfSjpw7Ciniu8gnEmtrC6v+/t3l3mS6GMV30a0109SmPmx1tyRPFBWUxHRGyQLpLUo7G
 7ZTw==
X-Gm-Message-State: AJcUukfHWa+0OJ0UKhaIM2b9mI6gZjC8Vqg7gdOQyBIbsHWIuZFATCHF
 q6hvHcz3VL8NanH/hhCQbHY=
X-Google-Smtp-Source: ALg8bN47o6Rqe+uaZF9wFXjaoxci4e+cXndEnBBvjiH+TT4ecdA3X+dxfIjNsZrcwc7TRCDv49DITw==
X-Received: by 2002:a50:8d12:: with SMTP id s18mr27666403eds.32.1548798424905; 
 Tue, 29 Jan 2019 13:47:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id y16sm8342edb.41.2019.01.29.13.47.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 13:47:03 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Liang Yang <liang.yang@amlogic.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit platforms
Date: Tue, 29 Jan 2019 14:46:57 -0700
Message-Id: <20190129214657.5877-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_134707_202230_E9690B4F 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On arm little endian allyesconfig:

  ld.lld: error: undefined symbol: __aeabi_uldivmod
  >>> referenced by meson_nand.c
  >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a

The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
(which wraps do_div) to prevent the compiler from emitting
__aebi_uldivmod.

Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index e858d58d97b0..6f12a96195d1 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
 				       div * NFC_CLK_CYCLE);
 	meson_chip->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
 					div * NFC_CLK_CYCLE);
-	tbers_clocks = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
-				    div * NFC_CLK_CYCLE);
+	tbers_clocks = DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
+					div * NFC_CLK_CYCLE);
 	meson_chip->tbers_max = ilog2(tbers_clocks);
 	if (!is_power_of_2(tbers_clocks))
 		meson_chip->tbers_max++;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
