Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CF62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmQ/e+m/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPkNV0+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hmdqpeYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CF62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UmZBHkg/hsmX/xxsK1TLFUQ5agrmRp1eNNAGSlcSdBY=; b=qmQ/e+m/8NC9nu
	lJLuZ8l2mQE+wn6SGCieJNsISMK0ppqv7ty11qrMi7rxv+DcyXa8aFMIVp+UA18/Dk8n2Ma1YYHn8
	cdqzia3JJwWhko+scwrrZXyydgYcGRdCoXvBd7k2rH6kIz5iKQlk14aTbqYJlrI8S+xPjmI63yQnA
	m1mTFfmmUaNP1rAvCEL2+hmc8+m5V9iv3BmLrhZh30yrDGs7v0tiwjZkYXmbs48zRj519DchQqMcQ
	1rSpCn53y8Tw/Vnu8hHkZ28j83drt28Ewe5HsuqUpaLjinuh2XFLCUSZn5hRFfa2hv/E7jM1fn9Ye
	K54LPZTli5p3/mWwt4MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCrg-0002qV-05; Thu, 31 Jan 2019 13:58:48 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqr-0002L9-79
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQ080XSy9CragrnXr938L/pI+v5aJ06V54Jlzfpdd30=; b=dPkNV0+FjCkSifxJcmPnUrkTnB
 VtWPd9A5XEwMtwYFcH8DQsNvio5xum2kbMXs9LsFIt4IDR7GiDGfpYvlIx1cpbwLCbSg/LX0bEs7U
 uzk+iEsKVvcmd47UlPhad9UIv9kzkxwPRPlFFX60BZxns0QEqFmYfsqRXPS4Zb70z7C8wSHSZaMVP
 x2uNbgGWDah1HAuDp26C2dgprxZwgEvloC7C/VNTbADkFp2bKdOdya9yOu1EGwslziWDn9Xct047w
 2uQ43s3JdSFyrChrw5YrIF85VH0miCjwq83/JC8CJuMYTQiPVTJFoYdN1YjtrSBAhU3f2EJ8zcZ/8
 jx5BrVwg==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZh-00067s-MG
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:19 +0000
Received: by mail-wr1-x441.google.com with SMTP id p7so3382200wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tQ080XSy9CragrnXr938L/pI+v5aJ06V54Jlzfpdd30=;
 b=hmdqpeYcpj+SLDsDzt/8vR5qdul/8gSSFcb/1wzDH9OetGMQltUKBb9OV8Qiz8OJwK
 6s8/AXuYShhh4K6bAtU8JQ4+LSOP70jsLF805U7aNpE88RQAuDRYVpRs1EkOHL98In1d
 vTwq/yf0tCLrgpC3NvRMe0HfU17YC1ExyTueq7V8y/nOor940hP0zAA37YgcwNo0G39E
 qe9U+Q66olaL3XVYe16/Dr7pfo1DbeDilXPJ9g+I7p76NCJBdfBeevweRbTcnR6DAHVL
 cXdPd4hd3SSO1foATQYlfeYt88lVR1CKi0egxob6TF69DtTJ1en+VEXb0Fhf1+jLO7Vp
 +9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tQ080XSy9CragrnXr938L/pI+v5aJ06V54Jlzfpdd30=;
 b=TJpJaKkPKavjQL9mwykrNJpW1G1MWhDgoY6fgi8zeoPHyyJ0+Uc5Qd51KjUSryLLgb
 wvnymBvsVapUxIoHt9IDWg0mpSCv7KjrKEnhzA+Fl/+ks/NCQD3i2U1D7o/8FLphfJgH
 ujELmg7ES2H0Yb4vVidwy7mUDc67HkXQDRLmrw878zxZMMxAwdK1z3waxcVREPJAD0Oy
 h4eXhWggNIwi1iNKtjCclBkJqZu5ncMUoB8BxWZWWsVRG1gm79f2jdArFQo3a4L4STcJ
 v5nGMgZTOTOvs3OIQIlKb2D4tKkd2TPxtNHfDmPRLRv46YLkOQSR8kIsTtt3HXJQedQw
 X66A==
X-Gm-Message-State: AJcUukcHcuUX/04O13GbuOSVsXjY0cVoDhTMn3fRQdrgPEErNdMViDQL
 kGzQWg6t0tETcSUM61fJ/3mT6Q==
X-Google-Smtp-Source: ALg8bN4qJy8KXPn1XXnN39DTI3SKbStCMBYqfVP9ZHSUPOBZXWwqKyeDtXVo9Y+MOG1/Ita1e5xTmg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr33635986wrt.63.1548942010166; 
 Thu, 31 Jan 2019 05:40:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 24/35] ARM: davinci: cp-intc: convert all hex numbers to
 lowercase
Date: Thu, 31 Jan 2019 14:39:17 +0100
Message-Id: <20190131133928.17985-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084013_736389_D783C1DC 
X-CRM114-Status: GOOD (  11.07  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use lowercase letters in hexadecimal numbers as is done in most of the
kernel code base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 3a99a3146d8e..1f55d68672db 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,19 +23,19 @@
 #include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
-#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0c
 #define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
 #define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
 #define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2c
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
 #define DAVINCI_CP_INTC_PRIO_IDX		0x80
 #define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
 #define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
 #define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0d00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0d80 + (n << 2))
 #define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 
 static void __iomem *davinci_cp_intc_base;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
